define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], () ->
  App = require 'app/app'
  Views = require 'base.views'

  App.module 'Profile.Notifications', (Notifications, App, Backbone, Mn, $, _) ->

    class Notifications.Layout extends Views.LayoutView
      template: 'profile/notifications/templates/layout'
      className: 'ui container'

      regions:
        formRegion: '#form-region'

    class Notifications.Form extends Views.ItemView
      template: 'profile/notifications/templates/form'
      tagName: 'form'
      className: 'ui tall stacked segment large form'

      triggers:
        'submit': 'submit'

      bindings:
        '[name=notify_by_email]':
          observe: 'notify_by_email'

        '[name=notify_by_phone]':
          observe: 'notify_by_phone'

        '[name=receive_delivery]':
          observe: 'receive_delivery'
