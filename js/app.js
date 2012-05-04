// app.js
define([
    'jquery', 
    'underscore',
    'backbone',
    'routers/main',
    'views/content/listed'
], function($, _, Backbone, mainRouter, listed) {
    return {
        initialize: function() {
            var l = new listed();
            console.log(l);
            console.log(mainRouter);
console.log(Backbone);
            Backbone.history.start();
            // you can use $, _ or Backbone here
        }
    }
});

