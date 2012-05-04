// main.js using RequireJS 1.0.7
require.config({
    paths: {
        'jquery': 'lib/jquery/jquery172.min',
        'underscore': 'lib/underscore/underscore132amdjs', // AMD support
        'backbone': 'lib/backbone/backbone091amdjs', // AMD support
        'templates': '../templates'
    }
});

require([
    'lib/require/domready', // optional, using RequireJS domReady plugin
    'app'
], function(domReady, app){
    domReady(function () {
        app.initialize();
    });
});


