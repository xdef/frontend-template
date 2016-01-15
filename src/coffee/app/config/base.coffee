# Add project configuration here
define [], ->
  data =
    debug: true

    # Default locale
    'locale': 'RU'

    # Base routes
    routes:
      root: '/'
      login: '/login'
      afterLogin: '/after_login_route'

    # OAuth2 providers (CLIENT_ID)
    'GOOGLE_API_KEY': '...'
    'GOOGLE_CLIENT_ID': '...'
    'GOOGLE_SCOPE': 'email profile'
    'GOOGLE_API_ENDPOINT': 'https://accounts.google.com/o/oauth2/v2/auth'

    'VK_CLIENT_ID': '...'
    'VK_SCOPE': ['email', 'status', 'offline', 'photos']
    'VK_API_VERSION': '5.40'
    'VK_API_ENDPOINT': 'https://oauth.vk.com/authorize'
