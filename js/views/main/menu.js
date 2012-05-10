define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/main/menu'
], function($, _, Backbone, tplMenu) {
	return Backbone.View.extend({
		tagName: 'nav',
		id: 'main',
		events: {
			"click #logout": "logout"
		},
		logout: function() {
			var self = this;
			$.post('/api/logout').error(function(response) { if (response.status == 401) self.navigate('login'); });
		},
		render: function() {
			this.$el.html(_.template(tplMenu));

			return this;
		}
	});
});