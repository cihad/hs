EDITOR.directive('headerTag', function($compile) {
  return {
    restrict: 'EA',
    replace: true,
    scope: { 
      tag: '=',
      widget: '=',
      model: '@'
    },
    link: function(scope, element, attrs) {
      var tag = scope.tag,
          model = scope.model,
          previousHeader = null;

      var template = function(tag, model) {
        return '<'+ tag +' medium-editor ' +
          'ng-model="'+ model +'" ' +
          'ng-class="{ \'bordered-bottom\' : widget.config.bordered }" ' +
          'options=\'{' +
            '"forcePlainText": true,' +
            '"disableReturn": true,' +
            '"buttons": ["bold", "italic", "underline", "anchor"],' +
            '"spellcheck": false' + 
          '}\'>' +
        '</'+ tag +'>';
      }

      scope.$watch('tag', function(tag) {
        if (previousHeader) {
          previousHeader.remove();
          previousHeader = null;
        };

        var view = $compile(template(tag, model))(scope)
        element.append(view);
        previousHeader = view;
      });

    }
  }
})