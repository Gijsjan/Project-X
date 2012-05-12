require.config paths:
    'jquery': 'lib/jquery/jquery172.min'
    'underscore': 'lib/underscore/underscore132amdjs'
    'backbone': 'lib/backbone/backbone091amdjs'
    'markdown': 'lib/Markdown.Converter'
    'domready': 'lib/require/domready'
    'text': 'lib/require/text'

require [
        'lib/require/domready'
        'app'
    ], (domready, app) ->
        domready ->
            app.initialize()