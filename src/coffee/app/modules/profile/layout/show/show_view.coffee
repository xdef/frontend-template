define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/info'
  './templates/menu'
], () ->
  App = require 'app/app'
  Views = require 'base.views'

  App.module 'Profile.Layout.Show', (Show, App, Backbone, Mn, $, _) ->

    class Show.Layout extends Views.LayoutView
      template: 'profile/layout/show/templates/layout'
      className: 'page-layout'

      regions:
        infoRegion: '#info-region'
        menuRegion: '#menu-region'
        contentRegion: '#content-region'

    class Show.Info extends Views.ItemView
      template: 'profile/layout/show/templates/info'
      className: 'ui container'

      modelEvents:
        'change:avatar': 'render'

      bindings:
        '[data-attr=first_name]':
          observe: 'first_name'

        '[data-attr=last_name]':
          observe: 'last_name'

    class Show.Menu extends Views.ItemView
      template: 'profile/layout/show/templates/menu'
      className: 'ui container'
