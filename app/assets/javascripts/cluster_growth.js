app.controller('formController', function ($scope, $http, $mdDialog) {
  $scope.logout = function (route) {
    $http.delete(route).then(function () {location.reload()}, function () {location.reload()})
  }

  $scope.sendForm = function () {
    $scope.formStatus = 'sending'
    $http.post('/cluster_growth', {growth_profile: $scope.growth_profile}).then(function () {
      console.log('Success')
      $scope.formStatus = 'saved'
    }, function () {
      console.log('Error')
      $scope.formStatus = 'error'
    })
  }
})
