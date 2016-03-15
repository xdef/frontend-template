define [
  'backbone'
  'backbone.stickit'
  'semantic-ui-dropdown'
  'semantic-ui-transition'
], ->

  Backbone.Stickit.addHandler
    selector: "input.dropdown"

    initialize: ($el, model, options) ->
      defaults = _.defaults options.defaultOptions, {}
      $el.parent().dropdown(defaults)

    update: ($el, val, model, options) ->
      if _.isEmpty val
        setTimeout ->
          $el.parent().dropdown 'clear'
        , 1
      else
        setTimeout ->
          $el.parent().dropdown 'set selected', val
        , 1
