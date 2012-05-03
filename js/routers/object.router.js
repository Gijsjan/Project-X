App.ObjectRouter = Backbone.Router.extend({
	routes: {
		":object_type/add": "add",
		":object_type/edit/:id": "edit",
		":object_type/:id": "show",
		":object_types": "collection"
	},
	add: function(object_type) {
		App.ObjectController.add(object_type);
		//App.EventDispatcher.trigger('add', {type: content});
	},
	show: function(object_type, id) {
		App.ObjectController.show(object_type, id);
		//App.EventDispatcher.trigger('show', {type: content_type, id: id});
	},
	edit: function(object_type, id) {
		App.ObjectController.edit(object_type, id);
		//App.EventDispatcher.trigger('edit', {type: content_type, id: id});
	},
	collection: function(object_types) {
		App.ObjectController.collection(object_types);
		//App.EventDispatcher.trigger('showContentCollection', {types: content});
	}
});