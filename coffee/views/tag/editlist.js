define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/tag/editlist'
], function($, _, Backbone, tplEditTagList) {
	return Backbone.View.extend({
		events: {
			"click span.del-tag": "deleteTag"
		},
		deleteTag: function(e) {
			this.options.parent.deleteTag(e);
		},
		tagName: 'ul',
		className: 'edit-tag-list',
		render: function() {
			var html = _.template(tplEditTagList, { "tags": this.collection });
			this.$el.html(html);
			
			return this;
		}
	});
});