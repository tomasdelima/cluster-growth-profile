app.controller('formController', function ($scope, $http, $mdDialog) {
  $scope.logout = function (route) {
    $http.delete(route).then(function () {location.reload()}, function () {location.reload()})
  }

  $scope.sendForm = function () {
    $http.post('/cluster_growth', $scope.form).then(function () {
      console.log('Success')
    }, function () {
      console.log('Error')
    })
  }
})
