define ["app/app", "base.controllers", "./password_view"], (App)->

  App.module "Auth.Password", (Password, App, Backbone, Mn, $, _) ->

    class Password.Controller extends App.Controllers.Base
      initialize: (options) ->
        { @region, params } = options
        @layout = @getLayoutView()

        @currentUser = App.reqres.request "user:current:entity"
        @currentUser.set _.pick(params, 'reset_password_token', 'email')

        @layout.on "show", =>
          @getFormView @currentUser

        @region.show @layout

      getLayoutView: ->
        new Password.Layout

      getFormView: (user) ->
        view = new Password.Form
          model: user

        view.on "submit", (args) =>
          { collection, model, view } = args

          App.commands.execute "user:password:restore", model

        @layout.formRegion.show view
