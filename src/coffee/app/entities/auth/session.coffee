define ['app/app', 'base.entities'], (App, Entities) ->

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    class Entities.Session extends Entities.Model
      idAttribute: 'authentication_token'

      getHeaders: ->
        headers =
          'X-User-Email': @get('email')
          'X-User-Token': @get('authentication_token')

        return headers: headers

    API =
      initializeSession: ->
        @session = new Entities.Session(
          App.reqres.request 'session:config:get')

        $.ajaxSetup @session.getHeaders()

      getSession: ->
        unless @session
          throw "Session should be initialized"

        @session

      createSession: (session, provider, options = {}) ->
        options = _.defaults options,
          wait: true
          url: Routes.user_session_path()
          success: (args...) ->
            App.vent.trigger 'session:create:success', args...

          error: (args...) ->
            App.vent.trigger 'session:error', args...

        provider = session.get('provider') || provider || 'local'
        code = session.get('code')

        switch provider
          when 'local'
            @localProvider session, options

          when 'google_oauth2'
            if code?
              @googleProviderCallback session, options
            else
              @googleProvider session, options

          when 'vkontakte'
            if code?
              @vkontakteProviderCallback session, options
            else
              @vkontakteProvider session, options

          else
            throw "Provider #{provider} should be defined"

      localProvider: (session, options = {}) =>
        session.validate = session._validateLocalProvider
        session.paramRoot = "user"

        options = _.extend options,
          url: Routes.user_session_path()

        session.save {}, options

      googleProvider: (session, options) ->
        params =
          client_id: App.reqres.request 'config', 'GOOGLE_CLIENT_ID'
          scope: App.reqres.request 'config', 'GOOGLE_SCOPE'
          redirect_uri: "#{window.location.origin}/login/google_oauth2"
          response_type: "code"

        endPoint = App.reqres.request 'config', 'GOOGLE_API_ENDPOINT'
        queryParams = $.param params

        window.location.replace "#{endPoint}?#{queryParams}"

      googleProviderCallback: (session, options) ->
        session.validate = session._validateVKontakteProvider

        options = _.extend options,
          url: Routes.user_omniauth_callback_path('google_oauth2')

        session.save {}, options

      vkontakteProvider: (session, options) ->
        params =
          client_id: App.reqres.request 'config', 'VK_CLIENT_ID'
          scope: App.reqres.request 'config', 'VK_SCOPE'
          v: App.reqres.request 'config', 'VK_API_VERSION'
          response_type: "code"
          redirect_uri: "#{window.location.origin}/login/vkontakte"
          display: "page"
          revoke: 1

        endPoint = App.reqres.request 'config', 'VK_API_ENDPOINT'
        queryParams = $.param params

        window.location.replace "#{endPoint}?#{queryParams}"

      vkontakteProviderCallback: (session, options) ->
        session.validate = session._validateVKontakteProvider

        options = _.extend options,
          url: Routes.user_omniauth_callback_path('vkontakte')

        session.save {}, options


      successSessionCreate: (model, response, options) ->
        # Create currentUser
        App.commands.execute 'user:current:create', _.omit(
          model.attributes, 'password', 'authentication_token', 'code')

        # Store headers in localStorage
        App.commands.execute 'session:config:store', _.pick(
          model.attributes, 'email', 'authentication_token')

        # Initialize new session
        App.commands.execute 'session:initialize'

        # Trigger broadcast message
        App.vent.trigger 'auth:login:success', model

        # Navigate to after_login_path
        reutnr_url = if @store and url = @store.getItem('return_url')
          @store.removeItem 'return_url'
          url
        else
          App.afterLoginRoute

        App.navigate reutnr_url, trigger: true

      destroySession: (options = {}) ->
        options = _.defaults options,
          url: Routes.destroy_user_session_path()

          success: (args...) =>
            @_afterDestroySession args...
            App.vent.trigger "auth:logout:success"

          error: (args...) =>
            @_afterDestroySession args...
            App.vent.trigger "auth:logout:error"

        @session.destroy options

      _afterDestroySession: (model, response, options) ->
        # Unset authentication cookies
        App.commands.execute 'session:config:remove'

        # Initialize new session
        App.commands.execute 'session:initialize'

        # Destroy user
        App.commands.execute 'user:current:destroy'

        # Navigate to login_path
        App.navigate App.loginRoute, {trigger: true}

      ### Config Store ###
      getStore: ->
        unless store = window.localStorage
          throw "Environment does not support localStorage!"

        store

      storeConfig: (params = {}) ->
        @store ||= @getStore()

        for key, value of params
          @store.setItem key, value

        # @store.setItem 'email', session.get('email')
        # @store.setItem 'authentication_token', session.get('authentication_token')

      removeConfig: (options = {}) ->
        @store ||= @getStore()

        @store.removeItem 'email'
        @store.removeItem 'authentication_token'

      getConfig: ->
        @store ||= @getStore()

        return {
          email: @store.getItem 'email'
          authentication_token: @store.getItem 'authentication_token'
        }

      ### Validate Session ###
      sessionIsValid: ->
        @session.validate = @session._validateSessionToken
        @session.isValid()


    ### Session ###
    App.reqres.setHandler "session:entity", (attrs = {}) ->
      API.getSession attrs

    App.commands.setHandler "session:initialize", (args...) ->
      API.initializeSession args...

    App.commands.setHandler "session:create", (args...) ->
      API.createSession args...

    App.commands.setHandler "session:google:oauth2", (args...) ->
      require ['google-platform'], ->
        API.createOAuth2Google args...

    App.commands.setHandler "session:destroy", (args...) ->
      API.destroySession args...


    ### Session handler ###
    App.vent.on 'session:create:success', (args...) ->
      API.successSessionCreate args...


    ### Store ###
    App.reqres.setHandler "session:config:get", (args...) ->
      API.getConfig args...

    App.commands.setHandler "session:config:store", (args...) ->
      API.storeConfig args...

    App.commands.setHandler "session:config:remove", (args...) ->
      API.removeConfig args...

    ### Helpers ###
    App.reqres.setHandler 'user:signed:in?', ->
      API.sessionIsValid()

    App.reqres.setHandler 'session:valid?', ->
      API.sessionIsValid()
