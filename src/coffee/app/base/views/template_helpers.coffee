define [
  "app/app",
  './view'
], (App) ->

  App.module "Views", (Views, App, Backbone, Mn, $, _) ->

    Mn.Renderer.templateHelpers =

      t: (args...) ->
        App.reqres.request 'i18n:t', args...

      l: (args...) ->
        App.reqres.request 'i18n:l', args...

      isSigned: ->
        App.reqres.request 'user:signed:in?'

      currentUser: ->
        if App.reqres.request 'user:signed:in?'
          user = App.reqres.request 'user:current:entity'
          user.attributes

      trunc: (str, n) ->
        if str and str.length > n
          str.substr(0, n-1) + ' ...'
        else
          str

      fullName: (user) ->
        "#{user.last_name}&nbsp;#{user.first_name}"

      formatedDate: (date, format='LLL') ->
        moment(date).format(format)

      formatedDuration: (duration) ->
        moment
          .duration(duration*1000)
          .format("mm:ss", { forceLength: true, trim: false })
