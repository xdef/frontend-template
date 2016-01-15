define ["app/app", "base.controllers", "./notifications_view"], (App)->

  App.module "Profile.Notifications", (Notifications, App, Backbone, Mn, $, _) ->

    class Notifications.Controller extends App.Controllers.Base

      initialize: (options) ->
        { @region } = options

        @layout = @getLayoutView()
        currentUser = App.reqres.request 'user:current:entity'

        @layout.on "before:show", =>
          @getFormView currentUser

        @region.show @layout

      getLayoutView: ->
        new Notifications.Layout

      getFormView: (user) ->
        view = new Notifications.Form
          model: user.get('setting')

        view.on 'submit', (args) ->
          { model, collection, view } = args
          App.commands.execute 'user:profile:update', user

        @layout.formRegion.show view

  App.Profile.Notifications.Controller
