/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("meetingsCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get("/api/v1/meetings.json").then(function(response) {
        $scope.meetings = response.data;
      });
    };

    $scope.sortBy = function(inputAttribute) {
      if (inputAttribute !== $scope.orderAttribute) {
        $scope.isDescending = false;
      } else {
        $scope.isDescending = !$scope.isDescending;
      }
      $scope.orderAttribute = inputAttribute;
    };

    $scope.createMeeting = function(inputName, inputAddress) {
      var params = {
        name: inputName,
        address: inputAddress
      };
      $http.post('/api/v1/meetings.json', params).then(function(response) {
        $scope.meetings.push(response.data);
      });
    }
  });
}());