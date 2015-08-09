angular.module('categories')
  .directive('categorySelect', function() {
    return {
      require: 'ngModel',
      scope: {
        categories: "=ngModel",
        title: "=title"
      },
      templateUrl: 'templates/category-select.html'
    }
  })
;