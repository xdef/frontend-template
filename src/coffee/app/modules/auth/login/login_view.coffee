define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], (App, Views) ->

  App.module "Auth.Login", (Login, App, Backbone, Mn, $, _) ->

    class Login.Layout extends Views.LayoutView
      template: 'auth/login/templates/layout'
      className: "page-layout"

      regions:
        formRegion: "#form-region"
        flashRegion: "#flash-region"

    class Login.Form extends Views.ItemView
      template: 'auth/login/templates/form'
      tagName: "form"
      className: "ui tall stacked segment large form"

      ui:
        signinBtn: '.signin'

      bindings:
        '[name=email]':
          observe: 'email'

        '[name=password]':
          observe: 'password'

      triggers:
        "submit": "submit"

      events:
        'click @ui.signinBtn': 'signin'

      modelEvents:
        'sync:start': 'syncStart'
        'sync:stop invalid': 'syncStop'

      syncStart: (e) ->
        @$el.addClass 'loading'

      syncStop: (e) ->
        @$el.removeClass 'loading'

      signin: (e) ->
        e.preventDefault()
        e.stopPropagation()
        provider = $(e.currentTarget).data 'provider'
        App.commands.execute 'session:create', @model, provider
