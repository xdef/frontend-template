define [
  'backbone'
  'backbone.stickit'
], ->

  Backbone.Stickit.addHandler
    selector: ".menu"

    initialize: ($el, model, options) ->
      defaults = _.defaults {}, options.defaultOptions

    update: ($el, val, model, options) ->
      $el.find('a').removeClass('active')
      $el.find("[data-attr=#{val}]").addClass('active')

    updateModel: false
