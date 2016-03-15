define [
  'async'
  'underscore'
  'jquery'
  'jquery-deparam'
  'backbone'
  'backbone.localStorage'
  'backbone.marionette'
  'backbone.stickit'
  'backbone.nested-attributes'
  'nprogress'
  'lightbox'
  'moment'
  'moment-ru'
  'i18n-js'
  'nls.ru'
  'nls.en'
  'routes'
  'moment-duration-format'
  'semantic-ui-transition'
  'semantic-ui-dropdown'
  'semantic-ui-checkbox'
  'semantic-ui-dimmer'
  'semantic-ui-popup'
  'semantic-ui-modal'
  'semantic-ui-api'
  'semantic-ui-rating'
], () ->
  window.moment = require('moment')

  I18n.defaultLocale = "ru"
  moment.locale I18n.defaultLocale
