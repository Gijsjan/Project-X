define([
    'jquery', 
    'underscore',
    'backbone',
], function($, _, Backbone) {
	return Backbone.Router.extend({
		routes: {
			"": "home"
		},
		home: function() {
			console.log('home');
		}
	});
}