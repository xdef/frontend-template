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
      className: 'ui labeled icon fixed top menu'

      regions:
        menu: '#menu-region'

    class Show.Menu extends Views.ItemView
      template: 'nav/show/templates/menu'
      className: 'ui container'

      ui:
        logoutBtn: 'a.logout'

      triggers:
        'click @ui.logoutBtn': 'logout'

      onRender: ->
        options =
          on: 'hover'
          delay:
            show: 50
            hide: 100

        @$('.ui.dropdown').dropdown(options)
