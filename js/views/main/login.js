define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/main/login'
], function($, _, Backbone, tplLogin, require) {
	return Backbone.View.extend({
		id: 'login-form',
		events: {
			"click #form-submit": "login",
			"keyup input#password": "onSubmit"
		},
		onSubmit: function(e) {
			if (e.keyCode == 13) this.login();
		},
		login: function() {
			var self = this;
			$.post(	'/api/login',
					{	username: $('#username').val(),
						password: $('#password').val()
					},
					function(data) {
						var href = (!self.options.href) ? '' : self.options.href;
						console.log(href);
						self.navigate(href);
						//var mainRouter = new MainRouter();
						//console.log(self.mainRouter);
						//self.mainRouter.navigate('/'+self.options.href);
						//console.log('/'+self.options.href);
						//self.ContentController.list();
					}
			).error(function(response) { console.log('views/main/login - login() error'); console.log(response); });
		},
		initialize: function() {
			//this.ContentController = require("controllers/content");
			//MainRouter = require("routers/main");
			//this.mainRouter = MainRouter();
			//console.log(this.mainRouter);
		},
		render: function() {
			this.$el.html(_.template(tplLogin));

			return this;
		}
	});
});