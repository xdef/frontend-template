define ['backbone.marionette'], ->

  _.extend Mn.Renderer,

    render: (template, data) ->
      path = JST[template]

      unless path
        throw "Template #{template} not found!"
      path(data)

  _.extend Mn.Application::,

    navigate: (route, options = {}) ->
      Backbone.history.navigate route, options

    getCurrentRoute: ->
      frag = Backbone.history.fragment
      if _.isEmpty(frag) then null else frag

    startHistory: (options = {}) ->
      if Backbone.history
        Backbone.history.start(options)
        @hijack() if options.pushState is true

        Backbone.history.on "route", @scrollUp

    hijack: ->
      $document = $(window.document)
      openLinkInTab = false

      is_relative_to_page = (href) ->
        _.isNull href.match(/^\/\/|(http:|https:|ftp:|mailto:|javascript:)/)

      is_routable = (href) ->
        href.indexOf("#") is -1 and is_relative_to_page(href) and not openLinkInTab

      $document.keydown (e) ->
        openLinkInTab = true if e.ctrlKey or e.keyCode is 91

      $document.keyup (e) ->
        openLinkInTab = false

      $(document).on "click", "a[href]:not([data-bypass])", (e) ->
        href = $(@).attr("href")

        if is_routable href
          e.preventDefault()
          Backbone.history.navigate href, true

    scrollUp: ->
      $("body").animate {"scrollTop" : 0}, 100
