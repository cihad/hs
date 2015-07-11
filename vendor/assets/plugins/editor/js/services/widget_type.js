EDITOR.factory('WidgetType', function($http) {

  var service = {
    widgets: [
      { 
        "name": "Header",
        "machineName": "hs/header",
        "version": 1,
        "value": "Lorem Ipsum Nedir?",
        "config": { 
          "tag": "h3"
        }
      },
      { 
        "name": "Paragraph",
        "machineName": "bootstrap/paragraph",
        "version" : 1,
        "value": "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>"
      },
      { 
        "name": "Horizontal Rule",
        "machineName": "hr",
        "version": 1
      },
      { 
        "name": "Image",
        "machineName": "bootstrap/image",
        "version": 1,
        "value": {
          "url": "",
          "caption": "The Caption"
        },
        "config": { 
          "type": "thumbnail",
          "caption": true
        }
      },
      { 
        "name": "Table",
        "machineName": "bootstrap/table",
        "version": 1,
        "value": [
          ["first", "last", "age"],
          ["cihad", "paksoy", "28"],
          ["huseyin", "gurluk", "25"]
        ],
        "config": {
          "rowCount": 3,
          "columnCount": 3
        }
      },
      {
        "name": "Grid",
        "machineName": "bootstrap/grid",
        "version": 1,
        "config": {
          "columns": [
            { 
              "name": "Blank Column",
              "machineName": "bootstrap/blank_column",
              "version": 1,
              "size": 6
            }
          ]
        }
      }
    ]
  };

  return service;
});