define [
  'app/app'
  'base.views'
  'bindings.datepicker'
  'bindings.uploader'
  './templates/layout'
  './templates/form'
  './templates/avatar'
], () ->
  App = require 'app/app'
  Views = require 'base.views'

  App.module 'Profile.Show', (Show, App, Backbone, Mn, $, _) ->

    class Show.Layout extends Views.LayoutView
      template: 'profile/show/templates/layout'
      className: 'ui container'

      regions:
        formRegion: '#form-region'

    class Show.UserAvatar extends Views.ItemView
      template: 'profile/show/templates/avatar'
      className: 'ui center aligned basic segment'

      ui:
        uploadButton: '.edit'
        file: 'input[type="file"]'
        dimmer: '.dimmer'
        loader: '.loader'

      bindings:
        '.uploader':
          observe: "avatar"
          defaultOptions:
            url: Routes.avatar_users_path()
            acceptFileTypes: /(\.|\/)(png|jpg|jpeg|gif)$/i

      events:
        'click @ui.uploadButton': 'openFile'

      modelEvents:
        'change:avatar': 'render'
        'upload:start': 'startUpload'
        'upload:stop': 'stopUpload'
        'upload:done': 'doneUpload'
        'upload:error': 'errorUpload'
        'upload:progress': 'progressUpload'

      openFile: (e) ->
        e.preventDefault()
        e.stopPropagation()

        @ui.file.trigger 'click'

      startUpload: ->
        @ui.dimmer.addClass('active')

      stopUpload: (data) ->
        @ui.dimmer.removeClass('active')

      doneUpload: (data) ->
        { avatar } = data.result
        @model.save { avatar: avatar }, { validate: false }

      errorUpload: (data) ->
        @ui.dimmer.removeClass('active')

      progressUpload: (value) ->
        @ui.loader.text("#{value}%")


    class Show.Form extends Views.LayoutView
      template: 'profile/show/templates/form'
      tagName: 'form'
      className: 'ui tall stacked segment large form'

      regions:
        avatar: '#user-avatar-region'

      bindings:
        '[name=first_name]':
          observe: 'first_name'

        '[name=last_name]':
          observe: 'last_name'

        '[name=date_of_birth]':
          observe: 'date_of_birth'
          defaultOptions:
            maxDate: moment().toDate()

            yearRange: [
              moment().subtract(120, 'y').year()
              moment().year()
            ]

        '[name=gender]':
          observe: 'gender'

      triggers:
        'submit': 'submit'
