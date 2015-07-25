EDITOR.filter('widgetConfigTemplateUrl', function() {
  
  return function(widget) {
    if (widget) {
      templateUrl = [
        'templates/widgets/',
        widget.machineName,
        '/config',
        widget.version,
        '.html'].join("");
    } else {
      templateUrl = "";
    }


    return templateUrl;
  }

});