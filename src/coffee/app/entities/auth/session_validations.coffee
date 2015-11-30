define ['app/app', 'base.entities', './session'], ->

  App = require 'app/app'

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    _.extend Entities.Session::,

      _validateLocalProvider: (attrs, options = {}) ->
        errors = []

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

        result = if errors.length then errors else undefined
        return result

      _validateSessionToken: (attrs, options = {}) ->
        errors = []

        # Check email
        if _.isEmpty attrs.email
          errors.push
            attr: "email"
            msg: ["Email"]

        # Check authentication_token
        if _.isEmpty attrs.authentication_token
          errors.push
            attr: "authentication_token"
            msg: ["Токен аутентификации"]

        result = if errors.length then errors else undefined
        return result

      _validateGoogleProvider: (attrs, options = {}) ->
        errors = []

        # Check code
        if _.isEmpty attrs.code
          errors.push
            attr: "code"
            msg: ["Code"]

        result = if errors.length then errors else undefined
        return result

      _validateVKontakteProvider: (attrs, options = {}) ->
        errors = []

        # Check code
        if _.isEmpty attrs.code
          errors.push
            attr: "code"
            msg: ["Code"]

        result = if errors.length then errors else undefined
        return result
