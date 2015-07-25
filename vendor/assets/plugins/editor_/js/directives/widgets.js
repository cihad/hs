EDITOR.directive('widgets', function() {
  return {
    require: 'ngModel',
    scope: {
      widgets: "=ngModel"
    },
    templateUrl: 'templates/app.html'
  }
});