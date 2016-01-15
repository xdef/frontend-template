define ["app/app", "base.controllers", "./password_view"], (App)->

  App.module "Profile.Password", (Password, App, Backbone, Mn, $, _) ->

    class Password.Controller extends App.Controllers.Base

      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request 'user:current:entity'
        @layout.on "before:show", =>
          @getFormView currentUser

        @region.show @layout

      getLayoutView: ->
        new Password.Layout

      getFormView: (user) ->
        view = new Password.Form
          model: user

        view.on 'submit', (args) =>
          { model, collection, view } = args
          App.commands.execute 'user:password:update', model

        @layout.formRegion.show view

  App.Profile.Password.Controller
