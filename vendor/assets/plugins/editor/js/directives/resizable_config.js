EDITOR.directive('resizableConfig', function () {
  return {
    restrict: 'A',
    scope: {},
    link: function postLink(scope, elem, attrs) {
      elem.resizable({
        handles: 'w'
      });
    },
  };
});