define ['app/app', 'base.entities'], (App, Entities) ->

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    class Entities.User extends Entities.Model
      initialize: (options) ->
        App.vent.on 'user:sign:in', =>
          @trigger 'sign:in'

        App.vent.on 'user:sign:out', =>
          @trigger 'sign:out'

      paramRoot: "user"
      # urlRoot: Routes.users_path()
      localStorage: new Backbone.LocalStorage("Users")

      defaults:
        # 0 - undefined
        # 1 - male
        # 2 - female
        first_name: undefined
        last_name: undefined
        gender: "0"
        date_of_birth: undefined

    class Entities.UsersCollection extends Entities.Collection
      model: Entities.User
      # url: Routes.users_path()
      localStorage: new Backbone.LocalStorage("Users")

    API =
      initializeCurrentUser: ->
        users = new Entities.UsersCollection()
        users.fetch()

        @currentUser = if users.length
          users.first()
        else
          new users.model {}, {validate: false}

      getCurrentUser: ->
        @currentUser

      createCurrentUser: (attrs, options) ->
        options = _.defaults options,
          validate: false
          ajaxSync: false

        @currentUser.save attrs, options

      destroyCurrentUser: (options = {}) ->
        @currentUser.destroy()
        @currentUser = @initializeCurrentUser()

    App.on 'start', (options = {}) ->
      API.initializeCurrentUser()

    App.reqres.setHandler "user:current:initialize", (args...) ->
      API.initializeCurrentUser args...

    App.reqres.setHandler "user:current:entity", ->
      API.getCurrentUser()

    App.commands.setHandler 'user:current:create', (args...) ->
      API.createCurrentUser args...

    App.commands.setHandler 'user:current:destroy', (args...) ->
      API.destroyCurrentUser(args...)
