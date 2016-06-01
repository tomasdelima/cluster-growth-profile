app.controller('formController', ['$scope', '$http', '$mdDialog', function ($scope, $http, $mdDialog) {
  $scope.logout = function (route) {
    $http.delete(route).then(function () {location.reload()}, function () {location.reload()})
  }

  $scope.calculateTotals = function (human_resource) {
    ['full_name', 'devotional_gatherings', 'children_classes', 'junior_youth_groups', 'study_circles', 'visits'].map(function (f) {
      $scope.growth_profile[human_resource][f + '_count'] = 0
      $scope.growth_profile[human_resource].map(function (g) {
        $scope.growth_profile[human_resource][f + '_count'] = Number($scope.growth_profile[human_resource][f + '_count']) + (Number(g[f]) || 0)
      })
    })
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
}])
