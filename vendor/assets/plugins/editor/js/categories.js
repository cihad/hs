angular.module('categories', ['puElasticInput'])
  
  .constant("categoriesUrl", "categories.json")

  .controller('CategoriesController', function($scope, $http, categoriesUrl) {
    $scope.categoryList = [];

    $scope.setCurrentCategory = function(index, cat) {
      $scope.categories[index] = {name: cat}
    }

    $scope.addCategory = function() {
      $scope.categories.push({name: ""});
    }

    function getCategoryNames(categories) {
      categories = []
      angular.forEach($scope.categories, function(cat) {
        categories.push(cat.name);
      });

      return categories;
    }


    $scope.$watch('categories', function(newValue, oldValue) {
      $http({
        url: categoriesUrl,
        params: { "terms[]": getCategoryNames($scope.categories) }
      }).then(function(response) {
        $scope.categoryList = response.data;
        
        while ($scope.categories.length < $scope.categoryList.length) {
          $scope.addCategory();
        }

      })
    }, true);

  })
;