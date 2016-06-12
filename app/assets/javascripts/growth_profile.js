app.controller('formController', ['$scope', '$http', '$mdDialog', function ($scope, $http, $mdDialog) {
  $scope.logout = function (route) {
    $http.delete(route).then(function () {location.reload()}, function () {location.reload()})
  }

  $scope.ns = {}
  $scope.formStatus = 'ok'

  $scope.calculateTotals = function (human_resource) {
    for(c=0; c<4; c++) {
      ['full_name', 'devotional_gatherings', 'children_classes', 'junior_youth_groups', 'study_circles', 'visits'].map(function (f) {
        $scope.growth_profiles[c][human_resource][f + '_count'] = 0
        $scope.growth_profiles[c][human_resource].map(function (g) {
          $scope.growth_profiles[c][human_resource][f + '_count'] = Number($scope.growth_profiles[c][human_resource][f + '_count']) + (Number(g[f]) || 0)
        })
      })
    }
  }

  $scope.sendForm = function () {
    $scope.formStatus = 'sending'
    data = {growth_profile: $scope.growth_profiles[3], cluster_id: $scope.cluster.id}
    $http.post('/growth_profile', data).then(function () {
      console.log('Success')
      $scope.formStatus = 'saved'
    }, function () {
      console.log('Error')
      $scope.formStatus = 'error'
    })
  }

  $scope.changeFormState = function () {
    $scope.formStatus = 'changed'
  }

  $scope.copyDataFromLastCycle = function (namespace) {
    if (confirm('Tem certeza? Isso vai apagar os dados apenas desta tabela e substitui-los pelos dados do ciclo anterior.')) {
      $scope.growth_profiles[3][namespace] = $scope.growth_profiles[2][namespace]
      $scope.changeFormState()
    }
  }
}])
