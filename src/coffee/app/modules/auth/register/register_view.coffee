define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
  './templates/providers'
], (App, Views) ->

  App.module "Auth.Register", (Register, App, Backbone, Mn, $, _) ->

    class Register.Layout extends App.Views.LayoutView
      template: 'auth/register/templates/layout'
      className: "page-layout"

      regions:
        providersRegion: '#providers-region'
        formRegion: "#form-region"

    class Register.Providers extends App.Views.ItemView
      template: 'auth/register/templates/providers'
      className: 'ui center aligned basic segment'

      ui:
        signinBtn: '.signin'

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

    class Register.Form extends App.Views.ItemView
      template: "auth/register/templates/form"
      tagName: "form"
      className: "ui tall stacked segment large form"

      bindings:
        '[name=email]':
          observe: 'email'

        '[name=password]':
          observe: 'password'

        '[name=password_confirmation]':
          observe: 'password_confirmation'

        '[name=first_name]':
          observe: "first_name"

        '[name=last_name]':
          observe: "last_name"

        '[name=birthday]':
          observe: "birthday"

        '[name=terms_of_use]':
          observe: "terms_of_use"

      triggers:
        "submit": "submit"

      modelEvents:
        'sync:start': 'syncStart'
        'sync:stop': 'syncStop'

      syncStart: (e) ->
        @$el.addClass 'loading'

      syncStop: (e) ->
        @$el.removeClass 'loading'
