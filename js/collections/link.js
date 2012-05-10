define([
	'backbone',
	'models/link'
], function(Backbone, mLink) {
	return Backbone.Collection.extend({
		model: mLink,
		url: 'api/links'
	});
});