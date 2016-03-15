define ['app/app', "./api"], (App, API) ->

  App.module "Home", (Home, App, Backbone, Mn, $, _) ->

    Home.on "start", (options = {}) ->
      API.show()
