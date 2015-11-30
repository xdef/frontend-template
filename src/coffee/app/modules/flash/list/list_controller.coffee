define ['app/app', 'base.controllers', './list_view'], (App) ->

  App.module 'Flash.List', (List, Backbone, Mn, $, _) ->

    class List.Controller extends App.Controllers.Base

      initialize: (options) ->
        { @region } = options
        @layout = @getLayoutView()

        messages = App.reqres.request 'flash:entities'
        App.commands.execute 'when:fetched', messages, =>
          @layout.on "show", =>
            @getMessagesView messages

          @region.show @layout

      getLayoutView: ->
        new List.Layout

      getMessagesView: (messages) ->
        view = new List.Messages
          collection: messages

        @layout.messagesRegion.show view

