define([
	'backbone',
	'models/document'
], function(Backbone, mDocument) {
	return Backbone.Collection.extend({
		model: mDocument,
		url: 'api/documents'
	});
});