define [
  'app/app'
  './home/home_controller'
], (App) ->

  API =
    home: (args...) ->
      new App.Pages.Home.Controller
        region: App.mainRegion
