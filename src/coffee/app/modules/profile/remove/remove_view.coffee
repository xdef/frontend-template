define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], () ->
  App = require 'app/app'
  Views = require 'base.views'

  App.module 'Profile.Remove', (Remove, App, Backbone, Mn, $, _) ->

    class Remove.Layout extends Views.LayoutView
      template: 'profile/remove/templates/layout'
      className: 'ui container'

      regions:
        formRegion: '#form-region'

    class Remove.Form extends Views.ItemView
      template: 'profile/remove/templates/form'
      tagName: 'form'
      className: 'ui tall stacked segment large form'

      triggers:
        'submit': 'submit'
