require.config 
    paths:
        'jquery': '../lib/jquery/jquery'
        'jqueryui': '../lib/jquery/jquery-ui'
        'bootstrap': '../lib/bootstrap/js/bootstrap'
        'underscore': '../lib/underscore/underscore'
        'backbone': '../lib/backbone/backbone'
        'markdown': '../lib/Markdown.Converter'
        'async': '../lib/async'
        'domready': '../lib/require/domready'
        'text': '../lib/require/text'
        'html': '../../html'

    shim:
        'underscore':
            exports: '_'
        'backbone':
            deps: ['underscore', 'jquery']
            exports: 'Backbone'
        'jqueryui': ['jquery']
        'bootstrap': ['jquery']

define (require) ->
    domready = require '../lib/require/domready'
    currentUser = require 'models/CurrentUser'
    app = require 'app'

    domready ->
        currentUser.authorize()
        currentUser.on 'loaded', ->
            app.initialize()