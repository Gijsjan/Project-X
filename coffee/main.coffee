require.config paths:
    'jquery': 'lib/jquery/jquery172'
    'underscore': 'lib/underscore/underscore133amdjs'
    'backbone': 'lib/backbone/backbone092amdjs'
    'markdown': 'lib/Markdown.Converter'
    'domready': 'lib/require/domready'
    'text': 'lib/require/text'
    'templates': '../../templates'

define (require) ->
    domready = require 'lib/require/domready'
    app = require 'app'

    domready ->
        app.initialize()