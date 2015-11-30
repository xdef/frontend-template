define ['app/app', "i18n"], (App, i18n) ->

  App.module "Translate", (Translate, App, Backbone, Mn, $, _) ->

    App.reqres.setHandler 'i18n:t', (args...) ->
      I18n.t args...
