define ["app/app", "base.controllers", "./show_view"], (App)->

  App.module "Profile.Show", (Show, App, Backbone, Mn, $, _) ->

    class Show.Controller extends App.Controllers.Base

      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request 'user:current:entity'
        @layout.on "before:show", =>
          @getFormView currentUser

        @region.show @layout

      getLayoutView: ->
        new Show.Layout

      getFormView: (user) ->
        view = new Show.Form
          model: user

        avatarView = new Show.UserAvatar
          model: user

        view.on 'before:show', ->
          view.showChildView 'avatar', avatarView

        view.on 'submit', (args) =>
          { model, collection, view } = args
          App.commands.execute 'user:profile:update', model

        @layout.formRegion.show view

  App.Profile.Show.Controller
