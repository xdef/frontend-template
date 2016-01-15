define ['app/app'], (App) ->

  App.module "Profile.Layout", (Layout, App, Backbone, Mn, $, _) ->

    @startWithParent = false

    API =
      show: (args...) ->
        require ['app/modules/profile/profile_api'], (Actions) ->
          Actions.layout(args...)

    Layout.on "before:start", (options = {}) ->
      appRouter = options.router

      Backbone.history.on "route", (router, route, params) ->
        Layout.stop() unless appRouter == router

    Layout.on "before:stop", (options = {}) ->
      Backbone.history.off "route", "", @

    Layout.on "start", (options = {}) ->
      API.show()
