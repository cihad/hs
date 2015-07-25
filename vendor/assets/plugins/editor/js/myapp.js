angular.module('hs', ['editor'])

.constant('imageUploadUrl', "/")

.controller('MainController', function($scope) {
  $scope.widgets = [];
});