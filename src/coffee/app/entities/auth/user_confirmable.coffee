define ['app/app', 'base.entities', './user'], (App, Entities) ->

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    App = require 'app/app'

    _.extend App.Entities.User::,

      _validateConfirmationSend: (attrs, options = {}) ->
        errors = []

        # Check confirmation_token
        if _.isEmpty attrs.confirmation_token
          errors.push
            attr: "confirmation_token"
            msg: ["Confirmation token"]

        result = if errors.length then errors else undefined
        return result

      _validateConfirmationRequest: (attrs, options = {}) ->
        errors = []

        # Check token
        if _.isEmpty attrs.email
          errors.push
            attr: 'email'
            msg: ['Email']

        result = if errors.length then errors else undefined
        return result


    API =
      confirmationSend: (user, options = {}) ->
        user.validate = user._validateConfirmationSend
        return unless user.isValid()

        user.trigger 'sync:start'
        jqxhr = $.get(
          Routes.user_confirmation_path(), _.pick(user.attributes, 'confirmation_token'))

        jqxhr.always ->
          user.trigger 'sync:stop'

        jqxhr.fail (response) ->
          unless errors = response.responseJSON
            console.log "Confirm| Unknow error: ", response
            return

          # Populate model by errors from server
          errors = errors.errors if _.isObject errors.errors
          for attr, msg of errors
            user.validationError ||= []
            user.validationError.push {attr: attr, msg: msg}

          # Notify
          title = App.reqres.request(
            'i18n:t', 'frontend.flash.auth.confirm.send.error.title')

          msg = user.formatedErrors()

          App.vent.trigger 'flash:create',
            type: 'error', title: title, message: msg

          App.navigate App.loginRoute, {trigger: true, replace: true}

        jqxhr.done (response) ->
          App.navigate App.loginRoute, trigger: true, replace: true
          # Notify
          title = App.reqres.request(
            'i18n:t', 'frontend.flash.auth.confirm.send.success.title')

          msg = App.reqres.request(
            'i18n:t', 'frontend.flash.auth.confirm.send.success.message')

          App.vent.trigger 'flash:create',
            type: 'success', title: title, message: msg


      confirmationRequest: (user, options = {}) ->
        user.validate = user._validateConfirmationRequest
        unless user.isValid()
          user.validationError
          return

        options = _.defaults options,
          url: Routes.user_confirmation_path()
          method: 'POST'
          ajaxSync: true

          success: (model, response, options) ->
            # Notify
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.confirm.request.success.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.confirm.request.success.message', {email: model.get('email')})

            App.vent.trigger 'flash:create',
              type: 'success', title: title, message: msg


          error: (model, response, options) ->
            # 

        user.save {}, options


    App.commands.setHandler "user:confirmation:send", (args...) ->
      API.confirmationSend args...

    App.commands.setHandler "user:confirmation:request", (args...) ->
      API.confirmationRequest args...
