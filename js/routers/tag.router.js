App.TagRouter = Backbone.Router.extend({
	routes: {
		"country/:name": "showCountry",
		"tag/:name": "showTag",
		"tag/edit/:name": "editTag",
		"tags": "showTags"
	},
	showCountry: function(name) {
		App.TagController.showCountry(name);
	},
	showTag: function(name) {
		App.TagController.showTag(name);
	},
	editTag: function(name) {
		App.TagController.editTag(name);
	},
	showTags: function() {
		App.TagController.showCollection();
	}
});