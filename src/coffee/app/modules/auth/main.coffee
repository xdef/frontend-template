define [
  'app/app',
], (App, API) ->

  App.module 'Auth', (Auth, App, Backbone, Mn, $, _) ->

    class Auth.Router extends Mn.AppRouter

      appRoutes:
        'login(/:provider)': 'login'
        'register': 'register'
        'forgot': 'forgot'
        'password': 'password'
        'confirm': 'confirm'

      execute: (callback, args, name) ->
        if App.reqres.request 'user:signed:in?'
          App.navigate App.afterLoginRoute, trigger: true
        else
          callback.apply @, args

    API =
      login: (args...) ->
        require ['app/modules/auth/auth_api'], (Actions) ->
          Actions.login(args...)

      register: (args...) ->
        require ['app/modules/auth/auth_api'], (Actions) ->
          Actions.register(args...)

      forgot: (args...) ->
        require ['app/modules/auth/auth_api'], (Actions) ->
          Actions.forgot(args...)

      password: (args...) ->
        require ['app/modules/auth/auth_api'], (Actions) ->
          Actions.password(args...)

      confirm: (args...) ->
        require ['app/modules/auth/auth_api'], (Actions) ->
          Actions.confirm(args...)

    Auth.on 'before:start', (options = {}) ->
      App.commands.execute 'session:initialize'

    Auth.on 'start', (options = {}) ->
      new Auth.Router
        controller: API
