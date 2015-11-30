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
  'moment'
  'moment-ru'
  'i18n-js'
  'nls.ru'
  'nls.en'
  'moment-duration-format'
  'semantic-ui-transition'
  'semantic-ui-dropown'
  'semantic-ui-dimmer'
  'semantic-ui-popup'
  'semantic-ui-modal'
  'semantic-ui-api'
], () ->
  moment = require('moment')

  I18n.defaultLocale = "ru"
  moment.locale I18n.defaultLocale
