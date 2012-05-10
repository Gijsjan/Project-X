define([
    'jquery',
    'underscore',
    'backbone',
    'views/content/listed',
    'views/main/pagination',
    'collections/contentlist/contentlist'
], function($, _, Backbone, vListedContent, vPagination, cContentList) {
	return Backbone.View.extend({
		id: 'contentlist',
		initialize: function() {
			var self = this;
			
			if (this.collection === undefined) this.collection = new cContentList();
			if (this.options.tag !== undefined) this.collection.url += '/api/tag/' + this.options.tag;
			if (this.options.country !== undefined) this.collection.url += '/api/country/' + this.options.country;

			this.collection.fetch({
				success: function(collection, response) {
					self.render();
				},
				error: function(collection, response) {
					console.log('views/contentlist/contentlist -> initialize -> fetch error');
					if (response.status == 401) self.navigate('login');
				}
			});
		},
		render: function() {
			var self = this;

			var pgn = new vPagination({'totalItems': this.collection.length});

			this.collection.each(function(model, index) {
				var t = new vListedContent({
					id: 'object-'+model.get('id'),
					className: 'content listed '+model.get('type'),
					model:model
				});

				pgn.addItem(index, t.render().el);
			});

			this.$el.html(pgn.render().el);
			
			return this;
		}
	});
});