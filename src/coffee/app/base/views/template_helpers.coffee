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

      returnUrl: (url) ->
        params = $.param return_url: window.location.pathname
        "#{url}?#{params}"

      trunc: (str, n) ->
        if str and str.length > n
          str.substr(0, n-1) + ' ...'
        else
          str

      fullName: (user) ->
        "#{user.last_name}&nbsp;#{user.first_name}"

      formatedPhone: (phone = "") ->
        phone
          .replace /\D/gi, ''
          .replace /^7|8/, '+7'
          .replace /(^\+7)(\d{3})(\d{3})(\d{2})(\d{2})/, '$1 ($2) $3-$4-$5'

      formatedDate: (date, format='LLL') ->
        moment(date).format(format)

      formatedDuration: (duration) ->
        moment
          .duration(duration*1000)
          .format("mm:ss", { forceLength: true, trim: false })

      dateRange: (start, end, format='') ->
        start = moment(start)
        end = moment(end)

        if start.month() is end.month()
          "#{start.format('D')} - #{end.format('D MMMM YYYY')}"
        else if start.year() is end.year()
          "#{start.format('D MMM')} - #{end.format('D MMM YYYY')}"
        else
          "#{start.format('D MMM YYYY')} - #{end.format('D MMM YYYY')}"

      startDateRange: (start, end, format = '') ->
        start = moment(start) if start
        end = moment(end) if end
        if start? and end?
          "с #{start.format('LL')} по #{end.format('LL')}"
        else if not start? and end?
          "не позднее #{end.format('LL')}"
        else
          "В любое время"
