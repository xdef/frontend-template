define [
  'backbone'
  'backbone.stickit'
  'async!google-maps'
], ->

  Backbone.Stickit.addHandler
    selector: "input.address"

    events: ['keyup', 'change', 'paste', 'cut']

    initialize: ($el, model, options) ->

      defaults = _.extend {}, options.defaultOptions,
        types: ['geocode']

      google.maps.event.addDomListener $el[0], 'keydown', (e) ->
        if e.keyCode == 13
          e.preventDefault()
          e.stopPropagation()

      autocomplete = new google.maps.places.Autocomplete $el[0], defaults

      autocomplete.addListener 'place_changed', ->
        location = autocomplete.getPlace().geometry.location
        model.set "coordinates": [location.lng(), location.lat()]
