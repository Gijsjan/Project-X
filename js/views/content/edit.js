define([
    'jquery',
    'underscore',
    'backbone',
    'views/object/edit',
    'views/tag/edit'
], function($, _, Backbone, vEditObject, vEditTags) {
	return vEditObject.extend({
		initialize: function() {
			vEditObject.prototype.initialize.apply(this);
		},
		render: function() {
			vEditObject.prototype.render.apply(this);

			var et = new vEditTags({model: this.model});
			this.$('.tags_wrapper').append(et.render().el);
			
			return this;
		}
	});
});