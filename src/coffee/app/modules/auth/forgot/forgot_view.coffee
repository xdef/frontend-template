define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], (App, Views) ->

  App.module "Auth.Forgot", (Forgot, App, Backbone, Mn, $, _) ->

    class Forgot.Layout extends App.Views.LayoutView
      template: 'auth/forgot/templates/layout'
      className: "page-layout"

      regions:
        formRegion: "#form-region"
        flashRegion: "#flash-region"

    class Forgot.Form extends App.Views.ItemView
      template: 'auth/forgot/templates/form'
      tagName: "form"
      className: "ui tall stacked segment large form"

      bindings:
        '[name=email]':
          observe: 'email'

      triggers:
        "submit": "submit"
