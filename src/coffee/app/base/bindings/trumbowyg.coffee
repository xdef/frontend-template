define [
  'backbone'
  'backbone.stickit'
  'trumbowyg'
  'trumbowyg.locale-ru'
], ->

  Backbone.Stickit.addHandler
    selector: "textarea.trumbowyg"

    initialize: ($el, model, options) ->
      options.defaultOptions ||= {}
      defaults = _.defaults options.defaultOptions,
        lang: 'ru'
        fullscreenable: false
        removeformatPasted: true
        autogrow: true

        btns: ['btnGrp-design', '|', 'btnGrp-lists']

      $el
        .trumbowyg(defaults)
        .on 'tbwchange tbwblur twbfocus', (e) ->
          $(e.currentTarget).trigger 'change', e

      $el.trumbowyg 'html', model.get('description')

    updateView: false

    destroy: ($el, model, options) ->
      $el.trumbowyg 'destroy'
