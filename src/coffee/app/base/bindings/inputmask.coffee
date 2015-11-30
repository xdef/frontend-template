define [
  'backbone'
  'backbone.stickit'
  'jquery.inputmask'
], ->

  Backbone.Stickit.addHandler
    selector: "input[data-inputmask]"

    initialize: ($el, model, options) ->

      defaults = _.defaults {}, options.defaultOptions,
        rightAlign: false

      $el.inputmask(defaults)

    destroy: ($el, model, options) ->
      #
