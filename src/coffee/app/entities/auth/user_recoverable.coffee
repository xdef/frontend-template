define ['app/app', 'base.entities', './user'], (App, Entities) ->

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    App = require 'app/app'

    _.extend App.Entities.User::,

      _validatePasswordUpdate: (attrs, options = {}) ->
        errors = []

        # Check password
        if _.isEmpty attrs.password
          errors.push
            attr: "password"
            msg: ["Новый пароль"]

        # Check password confirmation
        if _.isEmpty attrs.password_confirmation
          errors.push
            attr: "password_confirmation"
            msg: ["Новый пароль (подтверждение)"]

        # Check current password
        if _.isEmpty attrs.current_password
          errors.push
            attr: "current_password"
            msg: ["Текущий пароль"]

        result = if errors.length then errors else undefined
        return result

      _validatePasswordRestore: (attrs, options = {}) ->
        errors = []

        # Check token
        if _.isEmpty attrs.reset_password_token
          errors.push
            attr: 'reset_password_token'
            msg: ['Reset password token']

        # Check email
        if _.isEmpty attrs.email
          errors.push
            attr: "email"
            msg: ["Email"]

        # Check password
        if _.isEmpty attrs.password
          errors.push
            attr: "password"
            msg: ["Пароль"]

        # Check password_confirmation
        if _.isEmpty attrs.password_confirmation
          errors.push
            attr: "password_confirmation"
            msg: ["Подтверждение пароля"]

        result = if errors.length then errors else undefined
        return result

      _validatePasswordRequest: (attrs, options = {}) ->
        errors = []

        # Check email
        if _.isEmpty attrs.email
          errors.push
            attr: "email"
            msg: ["Email"]

        result = if errors.length then errors else undefined
        return result


    API =
      requestPassword: (user, options) ->
        user.validate = user._validatePasswordRequest
        return unless user.isValid()

        options = _.defaults options,
          url: Routes.user_password_path()
          ajaxSync: true

          success: (model, response, options) ->
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.password.request.success.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.password.request.success.message', {email: model.get('email')})

            App.commands.execute 'user:current:clear'

            App.vent.trigger 'flash:create',
              type: 'success', title: title, message: msg

          error: (model, response, options) ->
            #

        user.save {}, options

      restorePassword: (user, options) ->
        user.validate = user._validatePasswordRestore
        return unless user.isValid()

        options = _.defaults options,
          url: Routes.user_password_path()
          method: 'PUT'
          ajaxSync: true

          success: (model, response, options) ->
            # Notify
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.password.restore.success.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.password.restore.success.message', {email: model.get('email')})

            # Destroy current user
            App.commands.execute 'user:current:destroy'

            # Navigate to login route
            App.navigate App.loginRoute, trigger: true, replace: true

            App.vent.trigger 'flash:create',
              type: 'success', title: title, message: msg

          error: (model, response, options) ->
            #

        user.save {}, options

      updatePassword: (user,options) ->
        user.validate = user._validatePasswordUpdate
        return unless user.isValid()

        options = _.defaults options,
          url: Routes.user_registration_path()
          method: 'PUT'
          ajaxSync: true

          success: (model, response, options) ->
            # SignOut
            App.commands.execute 'session:destroy'

            # Notify
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.password.update.success.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.auth.password.update.success.message', {email: model.get('email')})

            App.vent.trigger 'flash:create',
              type: 'success', title: title, message: msg

          error: (model, response, options) ->
            # 

        user.save {}, options


    App.commands.setHandler "user:password:update", (user, options = {}) ->
      API.updatePassword(user, options)

    App.commands.setHandler "user:password:request", (user, options = {}) ->
      API.requestPassword(user, options)

    App.commands.setHandler "user:password:restore", (user, options = {}) ->
      API.restorePassword(user, options)
