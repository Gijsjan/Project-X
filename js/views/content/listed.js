define([
    'jquery', 
    'underscore',
    'backbone',
], function($, _, Backbone) {
	return Backbone.View.extend({
		render: function() {
			this.$el.html(_.renderTemplate('Listed', this.model));
			this.$el.append(_.renderTags(this.model));

			return this;
		}
	});
});