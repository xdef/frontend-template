define [
  'backbone'
  'backbone.stickit'
  'jquery-date-range-picker'
  'moment'
], ->
  moment = require('moment')

  Backbone.Stickit.addHandler
    selector: ".date-range-picker"

    initialize: ($el, model, options) ->
      attrs = options.observe
      data1 = model.get(attrs[0])
      data2 = model.get(attrs[1])

      defaults = _.extend {}, options.defaultOptions,
        autoClose: true
        separator: '  -  '
        startOfWeek: 'monday'
        format: 'll'
        time: { enabled: false }
        showShortcuts: false
        showTopbar: true
        language: moment.locale()

      $el.dateRangePicker(defaults)
        .bind 'datepicker-change', (e, obj) ->
          { date1, date2 } = obj
          model.set attrs[0], moment(date1).startOf('day').toISOString()
          model.set attrs[1], moment(date2).endOf('day').toISOString()

      $el.data('dateRangePicker').setDateRange(
        moment(data1).format('ll'), moment(data2).format('ll')
      ) if data1 and data2

    destroy: ($el, model, options) ->
      $el.data('dateRangePicker').destroy()

    updateView: false
    updateModel: false
