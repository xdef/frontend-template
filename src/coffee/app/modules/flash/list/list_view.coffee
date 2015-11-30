define [
  'app/app'
  'base.views'
  './templates/layout'
  './templates/success'
  './templates/info'
  './templates/error'
  './templates/warning'
], (App, Views) ->

  App.module "Flash.List", (List, App, Backbone, Mn, $, _) ->

    class List.Layout extends Views.LayoutView
      template: 'flash/list/templates/layout'
      className: 'ui doubling padded stackable page grid'

      regions:
        messagesRegion: '#messages-region'

    class List.Message extends Views.ItemView
      className: 'item'
      getTemplate: ->
        switch @model.get('type')
          when 'success'  then 'flash/list/templates/success'
          when 'info'     then 'flash/list/templates/info'
          when 'error'    then 'flash/list/templates/error'
          when 'warning'  then 'flash/list/templates/warning'

          else 'flash/list/templates/unknow'

      ui:
        close: 'i.close'

      events:
        'click @ui.close': 'close'

      close: (e) =>
        @$el.transition 'slide down', =>
          @model.destroy()

      setTimer: =>
        setTimeout ( =>
          @close()
        ), @model.get('timer')

      onRender: ->
        @setTimer()


    class List.Messages extends Views.CollectionView
      tagName: 'div'
      className: 'ui list'

      childView: List.Message
      childViewEventPrefix: 'message'
