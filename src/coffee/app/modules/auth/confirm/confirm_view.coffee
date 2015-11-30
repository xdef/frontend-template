define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], (App, Views) ->

  App.module "Auth.Confirm", (Confirm, App, Backbone, Mn, $, _) ->

    class Confirm.Layout extends App.Views.LayoutView
      template: 'auth/confirm/templates/layout'
      className: "page-layout"

      regions:
        formRegion: "#form-region"

    class Confirm.Form extends App.Views.ItemView
      template: 'auth/confirm/templates/form'
      tagName: "form"
      className: "ui tall stacked segment large form"

      triggers:
        "submit": "submit"

      modelEvents:
        'sync:start': 'syncStart'
        'sync:stop': 'syncStop'

      syncStart: (e) ->
        @$el.addClass 'loading'

      syncStop: (e) ->
        @$el.removeClass 'loading'
