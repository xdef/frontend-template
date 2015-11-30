define ['app/app', 'base.entities', './user'], (App, Entities) ->

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    App = require 'app/app'

    _.extend App.Entities.User::,

      _validateProfileCreate: (attrs, options = {}) ->
        errors = []

        # Check first name
        if _.isEmpty attrs.first_name
          errors.push
            attr: "first_name"
            msg: ["Имя"]

        # Check last name
        if _.isEmpty attrs.last_name
          errors.push
            attr: "last_name"
            msg: ["Фамилия"]

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

        # Terms of Use
        unless attrs.terms_of_use is true
          errors.push
            attr: 'terms_of_use'
            msg: ['Пользовательское соглашение']

        result = if errors.length then errors else undefined
        return result

      _validateProfileUpdate: (attrs, options = {}) ->
        errors = []

        # Check first name
        if _.isEmpty attrs.first_name
          errors.push
            attr: "first_name"
            msg: ["Имя"]

        # Check last name
        if _.isEmpty attrs.last_name
          errors.push
            attr: "last_name"
            msg: ["Фамилия"]

        result = if errors.length then errors else undefined
        return result

    API =
      createProfile: (user, options = {}) ->
        user.validate = user._validateProfileCreate
        return unless user.isValid()

        options = _.defaults options,
          url: Routes.user_registration_path()
          ajaxSync: true

          success: (model, response, options) ->
            # Get email
            email = model.get('email')
            url = "/confirm?email=#{email}"

            # Destroy user
            App.commands.execute 'user:current:destroy'

            # Reinitialize new guest user
            App.commands.execute 'user:init'

            # Trigger event
            App.vent.trigger "auth:user:registered", model

            # Navigate to confirmation url
            App.navigate url, { trigger: true }

          error: (model, response, options) ->
            #

        user.save {}, options

      updateProfile: (user, options = {}) ->
        user.validate = user._validateProfileUpdate
        return unless user.isValid()

        options = _.defaults options,
          ajaxSync: true

          success: (model, response, options) ->
            # Update current user in localStorage
            App.commands.execute 'user:current:create', model.attributes

            # Notify
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.profile.update.success.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.profile.update.success.message', {email: model.get('email')})

            App.vent.trigger 'flash:create',
              type: 'success', title: title, message: msg

          error: (model, response, options) ->
            #

        user.save {}, options

      destroyProfile: (user, options = {}) ->
        unless App.reqres.request "user:signed:in?"
          return

        options = _.defaults options,
          ajaxSync: true

          success: (model, response, options) ->
            # Sing out
            App.commands.execute 'session:destroy'

            # Notify
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.profile.destroy.success.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.profile.destroy.success.message')

            App.vent.trigger 'flash:create',
              type: 'success', title: title, message: msg

          error: (model, response, options) ->
            # Notify
            title = App.reqres.request(
              'i18n:t', 'frontend.flash.profile.destroy.error.title')

            msg = App.reqres.request(
              'i18n:t', 'frontend.flash.profile.destroy.error.message')

            App.vent.trigger 'flash:create',
              type: 'error', title: title, message: msg

        user.destroy options


    App.commands.setHandler "user:profile:create", (args...) ->
      API.createProfile(args...)

    App.commands.setHandler "user:profile:update", (args...) ->
      API.updateProfile(args...)

    App.commands.setHandler "user:profile:destroy", (args...) ->
      API.destroyProfile(args...)
