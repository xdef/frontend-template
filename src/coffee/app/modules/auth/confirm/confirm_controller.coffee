define ["app/app", "base.controllers", "./confirm_view"], (App)->

  App.module "Auth.Confirm", (Confirm, App, Backbone, Mn, $, _) ->

    class Confirm.Controller extends App.Controllers.Base
      initialize: (options) ->
        { @region, params } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request 'user:current:entity'
        currentUser.set _.pick(params, 'email')

        @layout.on "show", =>
          @getLoginForm currentUser

        @region.show @layout

      getLayoutView: ->
        new Confirm.Layout

      getLoginForm: (user) ->
        view = new Confirm.Form
          model: user

        view.on 'submit', (args) =>
          { collection, model, view } = args

          App.commands.execute "user:confirmation:request", model

        @layout.formRegion.show view
