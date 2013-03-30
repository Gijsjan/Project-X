require.config 
    paths:
        'jquery': '../lib/jquery/jquery'
        'bootstrap': '../lib/bootstrap/js/bootstrap'
        'underscore': '../lib/underscore' # TODO change to LoDash (build for Backbone and AMD)
        'backbone': '../lib/backbone'
        'markdown': '../lib/markdown' # TODO remove?
        'moment': '../lib/moment' # TODO remove?
        'async': '../lib/async'
        'domready': '../lib/require/domready'
        'text': '../lib/require/text'
        'html': '../../html'

    # TODO underscore (lodash?) and backbone are both AMD, so remove shim?
    shim:
        'underscore':
            exports: '_'
        'backbone':
            deps: ['underscore', 'jquery']
            exports: 'Backbone'
        'bootstrap': 
            deps: ['jquery']
            exports: 'bootstrap'

require ['domready', 'models/CurrentUser', 'app'], (domready, currentUser, app) ->
# define (require) ->
#     domready = require '../lib/require/domready'
#     currentUser = require 'models/CurrentUser'
#     app = require 'app'

    domready ->
        currentUser.authorize()
        currentUser.on 'loaded', ->
            app.initialize()