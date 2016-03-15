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
    'GOOGLE_API_KEY': 'AIzaSyD2herFRkiQzhnqunDxe764Pdsp6IUs04I'
    'GOOGLE_CLIENT_ID': '53157603238-hld6ld0t2315i4pkeus7voi6aqjgtis3.apps.googleusercontent.com'
    'GOOGLE_SCOPE': 'email profile'
    'GOOGLE_API_ENDPOINT': 'https://accounts.google.com/o/oauth2/v2/auth'

    'VK_CLIENT_ID': '5274265'
    'VK_SCOPE': ['email', 'status', 'offline', 'photos']
    'VK_API_VERSION': '5.40'
    'VK_API_ENDPOINT': 'https://oauth.vk.com/authorize'

    # Google Maps
    map:
      options:
        styles: [{
          featureType: "all"
          stylers: [{
            saturation: -80
          }]
        }, {
          featureType: "road.arterial"
          elementType: "geometry"
          stylers: [{
            hue: "#00ffee"
          }, {
            saturation: 50
          }]
        }, {
          featureType: "poi.business"
          elementType: "labels"
          stylers: [{
            visibility: "off"
          }]
        }]

        scrollwheel: true
        zoomControl: true
        mapTypeControl: false
        streetViewControl: false
        zoom: 14
        maxZoom: 15
        minZoom: 12

      clusterer:
        gridSize: 10
        maxZoom: 15

      icon:
        simple:
          path: 0 # google.maps.SymbolPath.CIRCLE
          scale: 6
          fillColor: '#767676'
          fillOpacity: 0.8
          strokeColor: '#767676'
          strokeOpacity: 1
          strokeWeight: 1

        red:
          path: 0 # google.maps.SymbolPath.CIRCLE
          scale: 6
          fillColor: '#DB2828'
          fillOpacity: 0.8
          strokeColor: '#DB2828'
          strokeOpacity: 1
          strokeWeight: 1

        green:
          path: 0 # google.maps.SymbolPath.CIRCLE
          scale: 6
          fillColor: '#21BA45'
          fillOpacity: 0.8
          strokeColor: '#21BA45'
          strokeOpacity: 1
          strokeWeight: 1

        hover:
          path: 0 # google.maps.SymbolPath.CIRCLE
          scale: 9
          fillColor: '#2185D0'
          fillOpacity: 1
          strokeColor: '#2185D0'
          strokeOpacity: 1
          strokeWeight: 1
