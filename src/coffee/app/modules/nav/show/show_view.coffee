define [
  'app/app', 'base.views',
  './templates/layout'
  './templates/menu'
], ->

  App = require 'app/app'
  Views = require 'base.views'

  App.module "Nav.Show", (Show, App, Backbone, Mn, $, _) ->
    class Show.Layout extends Views.LayoutView
      template: 'nav/show/templates/layout'
      tagName: 'nav'

      regions:
        menuRegion: '#menu-region'

    class Show.Menu extends Views.ItemView
      template: 'nav/show/templates/menu'
      className: 'ui container'

      onRender: ->
        options =
          on: 'hover'
          delay:
            show: 50
            hide: 100

        @$('.ui.dropdown').dropdown(options)
