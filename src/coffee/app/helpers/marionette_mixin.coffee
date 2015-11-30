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
        @hijack() if options.pushState

    hijack: ->
      $document = $(window.document)
      openLinkInTab = false

      $document.keydown (e) ->
        openLinkInTab = true if e.ctrlKey or e.keyCode is 91

      $document.keyup (e) ->
        openLinkInTab = false

      $(document).on "click", "a", (e) ->
        href = $(@).attr("href")
        domain = $(@).prop("hostname")

        isCSRF = domain is not document.location.hostname
        hasHashLink = href.indexOf("#") is -1

        if !openLinkInTab and !isCSRF and hasHashLink
          e.preventDefault()
          Backbone.history.navigate href, true
