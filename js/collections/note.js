define([
	'backbone',
	'models/note'
], function(Backbone, mNote) {
	return Backbone.Collection.extend({
		model: mNote,
		url: 'api/notes'
	});
});