define ["app/app", "base.controllers", "./remove_view"], (App)->

  App.module "Profile.Remove", (Remove, App, Backbone, Mn, $, _) ->

    class Remove.Controller extends App.Controllers.Base

      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request 'user:current:entity'
        @layout.on "before:show", =>
          @getFormView currentUser

        @region.show @layout

      getLayoutView: ->
        new Remove.Layout

      getFormView: (user) ->
        view = new Remove.Form
          model: user

        view.on 'submit', (args) ->
          { model, collection, view } = args

          App.commands.execute 'user:profile:destroy', user

        @layout.formRegion.show view

  App.Profile.Remove.Controller
