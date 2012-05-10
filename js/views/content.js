/*
App.Views.FullContent = App.Views.FullObject.extend({
	render: function() {
		App.Views.FullObject.prototype.render.apply(this);

		this.$el.append(_.renderTags(this.model));
		this.$el.append(_.renderComments(this.model));

		return this;
	}
});

App.Views.ListedContent = Backbone.View.extend({
	render: function() {
		this.$el.html(_.renderTemplate('Listed', this.model));
		this.$el.append(_.renderTags(this.model));

		return this;
	}
});

App.Views.EditContent = App.Views.EditObject.extend({
	render: function() {
		App.Views.EditObject.prototype.render.apply(this);

		var editTags = new App.Views.EditTags({model: this.model});
		this.$('.tags_wrapper').append(editTags.render().el);
		
		return this;
	}
});
*/