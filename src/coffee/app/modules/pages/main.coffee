define ['app/app'], (App, API) ->

  App.module "Pages", (Pages, App, Backbone, Mn, $, _) ->

    class Pages.Router extends Mn.AppRouter
      appRoutes:
        "": "home"
        "home": "home"

    API =
      home: (args...) ->
        require ['app/modules/pages/api'], (Actions) ->
          Actions.home(args...)

    Pages.on "start", (options = {}) ->
      new Pages.Router
        controller: API
