# <div class="ui fluid search selection dropdown">
#   <input type="hidden" class="single dropdown" id="vendor" name="vendor" value="">
#   <div class="default text">Марка</div>
#   <i class="dropdown icon"></i>
#   <div class="menu"></div>
# </div>

define ['backbone', 'backbone.stickit', 'semantic-ui-dropdown'], ->
  Backbone.Stickit.addHandler
    selector: ".single.dropdown"

    initialize: ($el, model, options) ->
      unless url = options.url
        throw "Dropdown bindings: url option should be presence"

      try
        url = url(model) if _.isFunction(url)

        defaults = _.defaults {}, options.defaultOptions,
          allowAdditions: false
          saveRemoteData: true

          message:
            addResult     : 'Add <b>{term}</b>'
            count         : '{count} selected'
            maxSelections : 'Max {maxCount} selections'
            noResults     : 'No results found.'

          fields:
            value: 'value'
            name: 'name'

          apiSettings:
            url: "#{url}?query[chars]={query}"

            onResponse: (response) ->
              { results: response.data }

          onChange: (value, text, $choice) ->
            model.trigger "#{options.observe}:dropdown:add", value

        $el.parent().removeClass('disabled')
      catch error
        defaults = {}
        $el.parent().addClass('disabled')

      $el.parent().dropdown defaults


      # unless model.get(options.observe)?.isNew()
      #   setTimeout ( ->
      #     $el.dropdown 'restore defaults'
      #   ), 100

    destroy: ($el, model, options) ->
      $el.parent().dropdown 'destroy'
