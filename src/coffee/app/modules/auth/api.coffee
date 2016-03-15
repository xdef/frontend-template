define [
  'app/app',
  './login/login_controller'
  './register/register_controller'
  './forgot/forgot_controller'
  './password/password_controller'
  './confirm/confirm_controller'
], (App) ->

  API =
    login: (provider, params = "") ->
      new App.Auth.Login.Controller
        region: App.mainRegion
        provider: provider
        params: $.deparam(params)

    register: (params = "") ->
      new App.Auth.Register.Controller
        params: $.deparam(params)
        region: App.mainRegion

    forgot: (params = {}) ->
      new App.Auth.Forgot.Controller
        region: App.mainRegion

    password: (params = "") ->
      new App.Auth.Password.Controller
        region: App.mainRegion
        params: $.deparam(params)

    confirm: (params = "") ->
      new App.Auth.Confirm.Controller
        region: App.mainRegion
        params: $.deparam(params)
