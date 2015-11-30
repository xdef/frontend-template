define [
  'app/app'
  './list/list_controller'
], (App) ->

  API =
    show: ->
      new App.Flash.List.Controller
        region: App.flashRegion

