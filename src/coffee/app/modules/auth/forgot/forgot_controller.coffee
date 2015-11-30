define ["app/app", "base.controllers", "./forgot_view"], (App)->

  App.module "Auth.Forgot", (Forgot, App, Backbone, Mn, $, _) ->

    class Forgot.Controller extends App.Controllers.Base
      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request "user:current:entity"
        @layout.on "show", =>
          @getLoginForm currentUser

        @region.show @layout

      getLayoutView: ->
        new Forgot.Layout

      getLoginForm: (user) ->
        view = new Forgot.Form
          model: user

        view.on "submit", (args) ->
          { collection, model, view } = args

          App.commands.execute "user:password:request", model

        @layout.formRegion.show view
