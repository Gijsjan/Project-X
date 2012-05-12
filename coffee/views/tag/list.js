define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/tag/list'
], function($, _, Backbone, tplTagList) {
	return Backbone.View.extend({
		tagName: 'ul',
		className: 'tags',
		render: function() {
			this.$el.html(_.template(tplTagList, { "tags": this.options.tags }));
			
			return this;
		}
	});
});