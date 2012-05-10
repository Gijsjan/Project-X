// Filename: router.js
define([
    'jQuery',
    'Underscore',
    'Backbone',
    'js/views/contentlist'
], function($, _, Backbone, vContentList){
    var AppRouter = Backbone.Router.extend({
        routes: {
          // Define some URL routes
          '': 'home'
        },
        home: function() {
            var cl = new vContentList();
            $('div#main').html(cl.el);
        }
    });

    var initialize = function(){
        var App = {};
//        var app_router = new AppRouter;
        Backbone.history.start();
    };

    return {
        initialize: initialize
    };
});

