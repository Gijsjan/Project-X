define([
    'jquery',
    'underscore',
    'backbone',
    'views/content/list',
    'views/main/login'
], function($, _, Backbone, vContentList, vLogin) {
	return Backbone.Router.extend({
		routes: {
			"": "home",
			"login": "login"
		},
		home: function() {
			var home = new vContentList();
			$('div#main').html(home.el);
		},
		login: function() {
			$('div#main').html(new vLogin().render().el);
		}
	});
});