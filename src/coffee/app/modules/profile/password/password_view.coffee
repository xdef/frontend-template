define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/form'
], () ->
  App = require 'app/app'
  Views = require 'base.views'

  App.module 'Profile.Password', (Password, App, Backbone, Mn, $, _) ->

    class Password.Layout extends Views.LayoutView
      template: 'profile/password/templates/layout'
      className: 'ui container'

      regions:
        formRegion: '#form-region'

    class Password.Form extends Views.ItemView
      template: 'profile/password/templates/form'
      tagName: 'form'
      className: 'ui tall stacked segment large form'

      triggers:
        'submit': 'submit'

      bindings:
        '[name=password]':
          observe: 'password'

        '[name=password_confirmation]':
          observe: 'password_confirmation'

        '[name=current_password]':
          observe: 'current_password'
