define ["app/app", "base.controllers", "./login_view"], (App)->

  App.module "Auth.Login", (Login, App, Backbone, Mn, $, _) ->

    class Login.Controller extends App.Controllers.Base
      beforeFilter: 'user:not:authorized!'

      initialize: (options) ->
        { @region, provider, params } = options
        @layout = @getLayoutView()

        if params.confirmation_token
          currentUser = App.reqres.request 'user:current:entity'
          currentUser.set _.pick(params, 'confirmation_token')

        session = App.reqres.request "session:entity"
        @layout.on "before:show", =>
          # Local login
          @getLoginForm session

          # Token confirmation
          if params.confirmation_token
            currentUser = App.reqres.request 'user:current:entity'
            currentUser.set _.pick(params, 'confirmation_token')
            @getConfirmationTokenView currentUser

          # OAuth2 confirmation
          else if params.code and provider?
            session.set
              code: params.code
              provider: provider

            @getOAuthProviderView session

        @region.show @layout

      getLayoutView: ->
        new Login.Layout

      getLoginForm: (session) ->
        view = new Login.Form
          model: session

        view.on "submit", (args) =>
          { collection, model, view } = args
          App.commands.execute "session:create", model

        @layout.formRegion.show view

      getConfirmationTokenView: (user) ->
        App.commands.execute 'user:confirmation:send', user

      getOAuthProviderView: (session) ->
        App.commands.execute 'session:create', session
