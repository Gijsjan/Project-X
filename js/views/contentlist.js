App.Views.ContentList = Backbone.View.extend({
	id: 'contentlist',
	initialize: function() {
		var self = this;
		
		if (this.collection === undefined) this.collection = new App.Collections.ContentList();
		if (this.options.tag !== undefined) this.collection.url += '/tag/' + this.options.tag;
		if (this.options.country !== undefined) this.collection.url += '/country/' + this.options.country;
		
		this.collection.fetch({
			success: function(collection, response) {
				self.render();
			},
			error: function(collection, response) {
				console.log('la');
				console.log(response);
			}
		});
	},
	render: function() {
		this.$el.html('');
		
		var div = $('<div />').attr('id', 'content-wrapper');

		this.collection.each(function(model) {
			var t = new App.Views.ListedContent({
				id: 'object-'+model.get('id'),
				className: 'content listed '+model.get('type'),
				model:model
			});
			div.append(t.render().el);
		});

		this.$el.append(div);
		
		return this;
	}
})