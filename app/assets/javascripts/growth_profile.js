app.controller('formController', ['$scope', '$http', '$mdDialog', function ($scope, $http, $mdDialog) {
  $scope.logout = function (route) {
    $http.delete(route).then(function () {location.reload()}, function () {location.reload()})
  }

  $scope.ns = {}
  $scope.formStatus = 'ok'

  $scope.showHelp = function (text, title) {
    $mdDialog.show(
      $mdDialog.alert()
      .title(title)
      .clickOutsideToClose(true)
      .textContent(text)
      .ok('Ok')
    )
  }

  $scope.calculateMainActivitiesCount = function () {
    for(var c = 0; c < 4; c++) {
      $scope.growth_profiles[c].mailActivitiesCount = 0
      var keys = ['devotional_gathering', 'children_classes', 'junior_youth_group', 'study_circle']
      keys.map(function (activity) {
        $scope.growth_profiles[c].mailActivitiesCount += $scope.growth_profiles[c][activity + '_count']
      })
    }
    $scope.changeFormState()
  }

  $scope.calculateTotals = function (human_resource, keys) {
    if(!keys) {
      var keys = ['full_name', 'devotional_gatherings', 'children_classes', 'junior_youth_groups', 'study_circles', 'visits']
    }

    for(var c = 0; c < 4; c++) {
      keys.map(function (f) {
        $scope.growth_profiles[c][human_resource][f + '_count'] = 0
        $scope.growth_profiles[c][human_resource].map(function (g) {
          $scope.growth_profiles[c][human_resource][f + '_count'] = Number($scope.growth_profiles[c][human_resource][f + '_count']) + (Number(g[f]) || 0)
        })
      })
    }

    if(human_resource == 'active_internal_human_resources' || human_resource == 'external_human_resources') {
      var cols = ['devotional_gatherings', 'children_classes', 'junior_youth_groups', 'study_circles', 'visits']
      $scope.growth_profiles[3][human_resource].map(function (person) {
        person.activities_count = 0
        cols.map(function (activity) {
          person.activities_count = Number((Number(person.activities_count) || 0) + (Number(person[activity]) || 0))
        })
      })
    }
  }

  $scope.addLines = function (table) {
    $("#" + table + " .hidden").removeClass('hidden')
    $("#" + table + " .add-lines").addClass('hidden')
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
    var confirm = $mdDialog.confirm()
          .title('Tem certeza?')
          .textContent('Isso vai apagar os dados apenas desta tabela e substitui-los pelos dados do ciclo anterior.')
          .ok('Sim')
          .cancel('Cancelar')
    $mdDialog.show(confirm).then(function() {
      $scope.growth_profiles[3][namespace] = $scope.growth_profiles[2][namespace]
      $scope.calculateTotals(namespace)
      $scope.changeFormState()
    })
  }

  $scope.showPastYears = function () {
    $('#choose-cycle .hidden').removeClass('hidden')
    $scope.hidePastCyclesButton = true
  }
}])
