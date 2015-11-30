define ['app/app', "./flash_api"], (App, API) ->

  App.module "Flash", (Flash, App, Backbone, Mn, $, _) ->

    Flash.on "start", (options = {}) ->
      API.show()
