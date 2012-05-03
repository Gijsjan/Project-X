App.Views.EditNote = App.Views.EditContent.extend({
	events: _.extend({}, App.Views.EditContent.prototype.events, {
		"keyup #body": "onKeyup",
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
		this.converter = new Markdown.Converter();
		this.busy = false;
	},
	render: function() {
		App.Views.EditContent.prototype.render.apply(this);

		this.renderPagedown(this.model.get('body'));

		return this;
	}
});