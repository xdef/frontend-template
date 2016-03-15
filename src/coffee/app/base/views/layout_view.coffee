define ["app/app"], (App) ->

  App.module "Views", (Views, App, Backbone, Mn, $, _) ->

    class Views.LayoutView extends Mn.LayoutView
      visibility:
        footer: true

      _checkVisibilty: ->
        for key, value of @visibility
          if value is true then $(key).show() else $(key).hide()

      render: ->
        # Controls visibility
        @_checkVisibilty()

        # Invoke original render function
        result = super

        # Apply stickit, listen errors
        if @model and @model instanceof Backbone.Model
          @stickit()
          @model.on 'invalid', @validationError, @

        # Return render result
        result
