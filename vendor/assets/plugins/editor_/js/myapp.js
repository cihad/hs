angular.module('hs', ['editor'])

  .factory('product', function() {

    var product = {}

    product.tags = ["lorem", "ipsum", "dolor"]
    product.body = []
    product.newTag;
    product.states = [
      ['Inceleme gerekiyor', 'remove'],
      ['Inceleniyor', 'eye-open'],
      ['Yayinlandi', 'ok'],
      ['Cop kutusunda', 'trash']
    ];
    product.status = product.states[0];


    return product;
  })

  .controller('ProductController', function($scope, product) {
    $scope.product = product;

    $scope.addTag = function() {
      if($scope.product.tags.indexOf($scope.product.newTag) < 0 && $scope.product.newTag != null) {
        $scope.product.tags.push($scope.product.newTag);
        $scope.product.newTag = null;
      }
    }

    $scope.removeTag = function(tag) {
      index = $scope.product.tags.indexOf(tag);
      if (index > -1) {
        $scope.product.tags.splice(tag, 1)
      }
    }

    $scope.removeTagIfEmpty = function() {
      if (($scope.product.newTag === "" || $scope.product.newTag == null) && $scope.product.tags.length > 0) {
        $scope.product.tags.pop();
      }
    }

    $scope.changeStatus = function() {
      i = $scope.product.states.indexOf($scope.product.status)
      $scope.product.status = $scope.product.states[(i+1) % $scope.product.states.length]
    }
  })

  .directive('ngEnter', function () {
    return function (scope, element, attrs) {
      element.bind("keydown keypress", function (event) {
        if(event.which === 13) {
          scope.$apply(function (){
            scope.$eval(attrs.ngEnter);
          });

          event.preventDefault();
        }
      });
    };
  })

  .directive('ngBackspace', function () {
    return function (scope, element, attrs) {
      element.bind("keydown keypress", function (event) {
        if(event.which === 8) {
          scope.$apply(function (){
            scope.$eval(attrs.ngBackspace);
          });
        }
      });
    };
  })

;