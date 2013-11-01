'use strict'

app = angular.module 'app', ['ui.bootstrap']


app
.config <[$routeProvider $locationProvider]> ++ ($routeProvider, $locationProvider) ->

  # use /tiltedApp rather than #/tiltedApp
  #$locationProvider.html5Mode true

  $routeProvider
  .when '/mathmo', templateUrl: '/views/main.html'
  .when '/mathmo/:cmd/:x/:t/:q' templateUrl: '/views/main.html'
  .otherwise redirectTo: '/views/main.html'

.run <[$rootScope]> ++ ($rootScope) ->

  # fire an event related to the current route
  $rootScope.$on '$routeChangeSuccess', (event, currentRoute, priorRoute) ->
    $rootScope.$broadcast "#{currentRoute.controller}$routeChangeSuccess", currentRoute, priorRoute
