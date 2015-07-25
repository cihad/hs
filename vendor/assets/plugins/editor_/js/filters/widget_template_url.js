EDITOR.filter('widgetTemplateUrl', function() {
  
  return function(widget) {
    templateUrl = [
      'templates/widgets/',
      widget.machineName,
      '/widget',
      widget.version,
      '.html'].join("")

    return templateUrl;
  }

});