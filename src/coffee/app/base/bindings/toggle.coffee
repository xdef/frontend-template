define [
  'backbone'
  'backbone.stickit'
  'semantic-ui-checkbox'
  'semantic-ui-transition'
], ->

  Backbone.Stickit.addHandler
    selector: "input.toggle"

    initialize: ($el, model, options) ->
      defaults = _.defaults {}, options.defaultOptions
      $el.parent().checkbox(defaults)
