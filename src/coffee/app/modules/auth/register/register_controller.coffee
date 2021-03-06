define ['app/app', 'base.controllers', './register_view'], (App) ->

  App.module 'Auth.Register', (Register, App, Backbone, Mn, $, _) ->

    class Register.Controller extends App.Controllers.Base
      beforeFilter: 'user:not:authorized!'

      initialize: (options) ->
        { @region, params } = options
        @layout = @getLayoutView()

        currentUser = App.reqres.request "user:current:entity"
        session = App.reqres.request "session:entity"

        App.commands.execute "session:config:store", _.pick(
          params, 'return_url')

        @layout.on "show", =>
          @getProvidersView session
          @getFormView currentUser

        @region.show @layout

      getLayoutView: ->
        new Register.Layout

      getProvidersView: (session) ->
        view = new Register.Providers
          model: session

        @layout.showChildView 'providersRegion', view

      getFormView: (user) ->
        view = new Register.Form
          model: user

        view.on "submit", (args) =>
          { model, collection, view } = args

          App.commands.execute "user:profile:create", model

        @layout.showChildView "formRegion", view
