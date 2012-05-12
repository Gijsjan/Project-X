define([
    'jquery',
    'underscore',
    'backbone',
    'markdown',
    'views/content/edit'
], function($, _, Backbone, Markdown, vEditContent) {
	return vEditContent.extend({
		events: _.extend({}, vEditContent.prototype.events, {
			"keyup #body": "onKeyup"
		}),
		onKeyup: function(e) {
			if (!this.busy) {
				this.busy = true;

				var self = this;
				setTimeout(function() {
					self.renderPagedown($(e.currentTarget).val());
				}, 1600);
			}
		},
		renderPagedown: function(text) {
			this.$('#pagedown').html(this.converter.makeHtml(text));
			this.$('#pagedown').scrollTop(this.$('#pagedown').height());
			this.busy = false;
		},
		initialize: function() {
			vEditContent.prototype.initialize.apply(this);

			this.converter = new Markdown.Converter();
			this.busy = false;
		},
		render: function() {
			vEditContent.prototype.render.apply(this);

			this.renderPagedown(this.model.get('body'));

			return this;
		}
	});
});