define([
    'jquery',
    'underscore',
    'backbone',
    'controllers/main'
], function($, _, Backbone, MainController) {
	return function (status, href) {
		if (status == 401) MainController.login(href);
	};
	/*
	return function(statusCode) {
		this.statusCode = statusCode;

		this.redirect = function() {
			if (this.statusCode == 401) MainController.login();
		};
	};
	*/
});