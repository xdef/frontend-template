define ["app/app", "base.controllers", "./home_view"], (App)->

  App.module "Pages.Home", (Home, App, Backbone, Mn, $, _) ->

    class Home.Controller extends App.Controllers.Base
      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        @layout.on "before:show", =>
          #

        @region.show @layout

      getLayoutView: ->
        new Home.Layout

  App.Pages.Home.Controller
