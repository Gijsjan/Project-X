require.config 
    paths:
        'jquery': '../lib/jquery/jquery'
        'jqueryui': '../lib/jquery/jquery-ui'
        'bootstrap': '../lib/bootstrap/js/bootstrap'
        'underscore': '../lib/underscore/underscore133amdjs'
        'backbone': '../lib/backbone/backbone092amdjs'
        'markdown': '../lib/Markdown.Converter'
        'domready': '../lib/require/domready'
        'text': '../lib/require/text'
        'html': '../../html'
    shim:
        'backbone':
            deps: ['underscore', 'jquery']
            exports: 'Backbone'
        'jqueryui': ['jquery']
        'bootstrap': ['jquery']

define (require) ->
    domready = require '../lib/require/domready'
    app = require 'app'

    domready ->
        app.initialize()