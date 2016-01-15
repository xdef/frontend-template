define ["app/app", "base.controllers", "./show_view"], (App)->

  App.module "Profile.Layout.Show", (Show, App, Backbone, Mn, $, _) ->

    class Show.Controller extends App.Controllers.Base

      initialize: (options) ->
        { @region } = options

        @layout = @getLayoutView()

        currentUser = App.reqres.request 'user:current:entity'

        App.reqres.setHandler "profile:layout:content", =>
          @layout.contentRegion

        @layout.on "before:show", =>
          @getInfoView currentUser
          @getMenuView()

        @region.show @layout

      getLayoutView: (user) ->
        new Show.Layout
          model: user

      getInfoView: (user) ->
        view = new Show.Info
          model: user

        @layout.infoRegion.show view

      getMenuView: ->
        view = new Show.Menu
        @layout.menuRegion.show view

  App.Profile.Layout.Show.Controller
