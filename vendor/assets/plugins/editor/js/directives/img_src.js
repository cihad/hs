EDITOR.directive('imgSrc', ['$parse', '$timeout', function ($parse, $timeout) {
  return {
    restrict: 'AE',
    link: function (scope, elem, attr, file) {
      if (window.FileReader) {
        scope.$watch(attr.imgSrc, function(file) {
          if (file) {
            $timeout(function() {
              var fileReader = new FileReader();
              fileReader.readAsDataURL(file);
              fileReader.onload = function(e) {
                $timeout(function() {
                  elem.attr('src', e.target.result);
                });
              }
            });
          } else {
            elem.attr('src', attr.placeholderImage);
          }
        });
      }
    }
  }
}])