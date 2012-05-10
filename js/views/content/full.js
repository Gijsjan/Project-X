define([
    'jquery',
    'underscore',
    'backbone',
    'helper',
    'views/object/full',
    'views/tag/list'
], function($, _, Backbone, helper, vFullObject, vTagList) {
	return vFullObject.extend({
		render: function() {
			vFullObject.prototype.render.apply(this);

			var tags = new vTagList({ tags: this.model.get('newtags') });
			var wrapper = $('<div />').addClass('tags_wrapper');
			wrapper.html(tags.render().el);

			this.$el.append(wrapper);
			//this.$el.append(helper.renderComments(this.model));

			return this;
		}
	});
});

