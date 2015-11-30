define ['backbone', 'backbone.stickit', 'semantic-ui-dropown'], ->
  Backbone.Stickit.addHandler
    selector: ".multiple.dropdown"

    initialize: ($el, model, options) ->
      unless url = options.url
        throw "Dropdown bindings: url option should be presence"

      defaults = _.defaults {}, options.defaultOptions,
        allowAdditions: true
        saveRemoteData: false

        message:
          addResult     : 'Add <b>{term}</b>'
          count         : '{count} selected'
          maxSelections : 'Max {maxCount} selections'
          noResults     : 'No results found.'

        fields:
          value: 'id'
          name: 'name'

        apiSettings:
          url: "#{url}?query[chars]={query}"

          onResponse: (response) ->
            { results: response.data }

        onAdd: (addedValue, addedText, $addedChoice) ->
          relation = model.get options.observe
          if relation instanceof Backbone.Collection
            relation.add { id: addedValue, name: addedText }

        onRemove: (removedValue, removedText, $removedChoice) ->
          relation = model.get options.observe
          if relation instanceof Backbone.Collection
            relation.remove { id: removedValue }

        onChange: (args...) ->
          # model.trigger 'dropdown:change'


      $el.dropdown defaults
      setTimeout ( ->
        $el.dropdown 'restore defaults'
      ), 100

    destroy: ($el, model, options) ->
      $el.dropdown 'destroy'

    updateView: false

    updateModel: false
