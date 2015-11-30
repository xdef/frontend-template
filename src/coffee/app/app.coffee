define [
  'backbone.marionette'
  'app/helpers/marionette_mixin'
], ->
  App = new Mn.Application

  App.addRegions
    navRegion: "#nav-region"
    flashRegion: "#flash-region"
    modalRegion: '#modal-region'
    mainRegion: "#main-region"
    footerRegion: "#footer-region"

  App.on "before:start", (options) ->
    # Application should return configuration options
    @reqres.setHandler 'config', (param) ->
      try
        return eval("options.#{param}")
      catch
        throw "Option with name \"#{param}\" should be exist in application config"


  App.on "start", (options = {}) ->
    console.log "start application", options
    @startHistory pushState: true

    unless @getCurrentRoute()
      @navigate @rootRoute, trigger: true

  App
