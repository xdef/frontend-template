define ['app/app', 'base.entities'], (App, Entities) ->

  App.module "Entities", (Entities, App, Backbone, Mn, $, _) ->

    class Entities.User extends Entities.RelationalModel
      initialize: (options) ->
        App.vent.on 'user:sign:in', =>
          @trigger 'sign:in'

        App.vent.on 'user:sign:out', =>
          @trigger 'sign:out'

      paramRoot: "user"
      urlRoot: Routes.users_path()
      localStorage: new Backbone.LocalStorage("Users")

      defaults:
        # 0 - undefined, 1 - female, 2 - male
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

        unless @currentUser.isNew()
          options =
            ajaxSync: true

            success: (model, response, options) ->
              App.commands.execute 'user:current:update', model.attributes

          @currentUser.fetch options

        @currentUser

      getCurrentUser: ->
        @currentUser

      saveCurrentUser: (attrs, options) ->
        options = _.defaults options,
          validate: false
          ajaxSync: false

        @currentUser.save attrs, options

      destroyCurrentUser: (options = {}) ->
        @currentUser.destroy()
        @currentUser = @initializeCurrentUser()

      ownerOfObject: (object = {}) ->
        user_id = if object instanceof Backbone.Model
          object.get("user")?.id || object.get("user_id")
        else
          object["user"]?["id"] || object["user_id"]

        @currentUser.id is user_id

    App.on 'before:start', (options = {}) ->
      API.initializeCurrentUser()

    App.reqres.setHandler "user:current:initialize", (args...) ->
      API.initializeCurrentUser args...

    App.reqres.setHandler "user:current:entity", ->
      API.getCurrentUser()

    App.reqres.setHandler 'user:owner?', (args...) ->
      API.ownerOfObject args...

    App.commands.setHandler 'user:current:create', (args...) ->
      API.saveCurrentUser args...

    App.commands.setHandler 'user:current:update', (args...) ->
      API.saveCurrentUser args...

    App.commands.setHandler 'user:current:destroy', (args...) ->
      API.destroyCurrentUser(args...)
