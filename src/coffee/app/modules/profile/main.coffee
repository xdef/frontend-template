define ['app/app', './layout/layout'], (App) ->

  App.module "Profile", (Profile, App, Backbone, Mn, $, _) ->

    class Profile.Router extends Mn.AppRouter
      appRoutes:
        'profile': 'info'
        'profile/notifications': 'notifications'
        'profile/password': 'password'
        'profile/remove': 'remove'
        'profile/.*': 'info'

      execute: (callback, args) ->
        if App.reqres.request 'user:signed:in?'
          App.module("Profile.Layout").on 'start', ->
            callback.apply @, args

          if App.module("Profile.Layout")._isInitialized
            callback.apply @, args

          App.module("Profile.Layout").start
            router: Profile.router

        else
          App.navigate App.loginRoute, trigger: true

    API =
      info: (args...) ->
        require ['app/modules/profile/profile_api'], (Actions) ->
          Actions.show(args...)

      notifications: (args...) ->
        require ['app/modules/profile/profile_api'], (Actions) ->
          Actions.notifications(args...)

      password: (args...) ->
        require ['app/modules/profile/profile_api'], (Actions) ->
          Actions.password(args...)

      remove: (args...) ->
        require ['app/modules/profile/profile_api'], (Actions) ->
          Actions.remove(args...)

    Profile.on "start", (options = {}) ->
      @router = new Profile.Router
        controller: API
