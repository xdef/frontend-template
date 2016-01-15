define ['app/app', "i18n"], (App, i18n) ->

  App.module "Translate", (Translate, App, Backbone, Mn, $, _) ->

    App.reqres.setHandler 'i18n:t', (args...) ->
      I18n.t args...

    App.reqres.setHandler 'i18n:l', (format, value) ->
      switch format
        when 'number' then I18n.toNumber(value)
        when 'currency'
          options = if I18n.currentLocale() is "ru"
            { format: '%n%u', unit: '<i class="rub icon"></i>', delimiter: "." ,precision: 0 }
          else
            { format: '%u%n', unit: '<i class="dollar icon"></i>', delimiter: "." ,precision: 0 }

          I18n.toCurrency value, options

        when 'percentage' then I18n.toPercentage(value)
        else value
