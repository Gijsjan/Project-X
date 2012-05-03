// Filename: router.js
define([
  'jQuery',
  'Underscore',
  'Backbone'
], function($, _, Backbone, Session){
  var AppRouter = Backbone.Router.extend({
    routes: {
      // Define some URL routes
      '': 'home'
    },
    home: function(){
      App.Views.home = new App.Views.ContentList();
      $('#main').html(App.Views.home.el);
    },
  });

  var initialize = function(){
    var app_router = new AppRouter;
    Backbone.history.start();
  };
  return {
    initialize: initialize
  };
});

