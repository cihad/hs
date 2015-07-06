EDITOR.controller('AppController', function($rootScope, $scope, $document, WidgetType) {
  $scope.WidgetType = WidgetType;

  $scope.getNumber = function(number) {
    return new Array(number);
  }

  $document.on('click', function() {
    $rootScope.$apply(function(){
      $rootScope.currentWidget = null;
    });
    console.log('Clicked Document!');
  })

  $scope.sortableWidgetOptions = {
    handle: '.handle',
    placeholder: 'highlight',
    axis: 'y' ,
    start: function(event, ui) {
      console.log('sorting started');
      angular.element('.highlight').height(ui.item.height());
    }
  }

  $scope.addColumn = function(widget, col) {
    widget.config.columns.push(col);
    $scope.newCol = {};
  }

  $scope.setCurrentWidget = function(widget) {
    console.log('SETTING WIDGET from app_controller');
    if (widget.name != "Grid") {
      $rootScope.currentWidget = widget;
    }
  }

  $scope.removeWidget = function(widget) {
    index = $scope.widgets.indexOf(widget);
    if (index > -1) {
      $scope.widgets.splice(index, 1)
      console.log('WIDGET REMOVED!');
    }
  }

  $scope.previewImage = function(image) {
    console.log('previewed image');
  }

  $scope.addWidget = function (widget) {
    var timestamp = Date.now();
    var newWidget = angular.copy(widget);
    newWidget['timestamp'] = timestamp;
    $scope.widgets.push(newWidget);
    console.log(widget);
  }

  $scope.dropCallback = function(event, ui) {
    sourceWidget = angular.element(ui.draggable).scope().widget;
    targetScope = angular.element(event.target).scope();
    targetCol = targetScope.widget;
    grid = targetScope.$parent.$parent.widget;
    index = grid.config.columns.indexOf(targetCol);
    size = targetCol.size;
    newCol = angular.copy(sourceWidget);
    newCol.size = size;
    grid.config.columns[index] = newCol;
  }

  $scope.setCurrentWidgetFromDirective = function(widget) {
    console.log('setting current widget from widget view.')
    console.log(widget);
    $rootScope.currentWidget = widget;
  }

  $scope.oneLineMedium = {
    "placeholder": false,
    "paste": { "forcePlainText": true },
    "disableReturn": true
  }

});
