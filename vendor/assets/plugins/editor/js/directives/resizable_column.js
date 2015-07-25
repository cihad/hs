EDITOR.directive('resizableColumn', function () {
  return {
    require: '?ngModel',
    restrict: 'A',
    scope: {
      ngModel: '='
    },
    link: function postLink(scope, elem, attrs, ngModel) {
      elem.resizable({
        helper: "ui-resizable-helper",
        handles: 'e'
      });

      elem.on('resizestart', function (event, ui) {
          elem.removeClass('easing');
      });

      elem.on('resizestop', function (event, ui) {
        if (callBack) callBack(elem);
        elem.addClass('easing');
      });

      function callBack(elem) {
        rowWidth = elem.parent().width();
        eWidth = elem.width();
        elem.css('width', '');
        elem.css('height', '');
        
        for (i = 12; i >= 0; i--) {
          colWidth = rowWidth * i / 12

          if(eWidth >= colWidth) {
            elem.addClass('col-md-' + (i + 1));
            scope.ngModel.size = i+1;
            return;
          }
        }

        elem.attr('class', elem.attr('class').replace(/\bcol-.*?\b/g, ''));

      }
    },
  };
});