define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], (App, Views) ->

  App.module "Auth.Password", (Password, App, Backbone, Mn, $, _) ->

    class Password.Layout extends App.Views.LayoutView
      template: 'auth/password/templates/layout'
      className: "page-layout"

      regions:
        formRegion: "#form-region"
        flashRegion: "#flash-region"

    class Password.Form extends App.Views.ItemView
      template: 'auth/password/templates/form'
      tagName: "form"
      className: "ui tall stacked segment large form"

      bindings:
        '[name=password]':
          observe: 'password'

        '[name=password_confirmation]':
          observe: 'password_confirmation'

      triggers:
        "submit": "submit"
