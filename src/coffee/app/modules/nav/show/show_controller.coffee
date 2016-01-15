define ['app/app', './show_view'], (App) ->

  App.module "Nav.Show", (Show, App, Backbone, Mn, $, _) ->

    class Show.Controller extends App.Controllers.Base
      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request 'user:current:entity'

        @layout.on "before:show", =>
          @getMenuRegion currentUser

        @region.show @layout

      getLayoutView: ->
        new Show.Layout

      getMenuRegion: (user) ->
        view = new Show.Menu
          model: cart

        App.vent.on "auth:logout:success", ->
          view.render()

        App.vent.on 'auth:login:success', ->
          view.render()

        user.on 'change:avatar', ->
          view.render()

        view.on 'logout', (args) ->
          { model, collection, view } = args
          App.commands.execute "session:destroy"

        @layout.showChildView 'menu', view

  App.Nav.Show.Controller
