define [
  'app/app'
  './layout/show/show_controller'
  './show/show_controller'
  './notifications/notifications_controller'
  './password/password_controller'
  './remove/remove_controller'
], (App) ->

  API =
    show: (args...) ->
      new App.Profile.Show.Controller
        region: @_getContentRegion()

    notifications: (args...) ->
      new App.Profile.Notifications.Controller
        region: @_getContentRegion()

    remove: (args...) ->
      new App.Profile.Remove.Controller
        region: @_getContentRegion()

    password: (args...) ->
      new App.Profile.Password.Controller
        region: @_getContentRegion()

    layout: (args...) ->
      new App.Profile.Layout.Show.Controller
        region: App.mainRegion

    _getContentRegion: ->
      App.module("Profile.Layout").start
        router: App.Profile.router

      App.reqres.request "profile:layout:content"
