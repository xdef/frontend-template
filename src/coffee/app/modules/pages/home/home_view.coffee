define [
  'app/app'
  'base.views'
  'fullPage'
  './templates/layout'
], () ->
  App = require 'app/app'
  Views = require 'base.views'

  App.module 'Pages.Home', (Home, App, Backbone, Mn, $, _) ->

    class Home.Layout extends Views.LayoutView
      template: 'pages/home/templates/layout'
      className: 'home-layout'

      onDestroy: ->
        $.fn.fullpage.destroy('all')

      onShow: ->
        options =
          scrollBar: false
          navigation: true

        @$el.fullpage options
