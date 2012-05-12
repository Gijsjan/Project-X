define([
	'backbone',
	'models/event'
], function(Backbone, mEvent) {
	return Backbone.Collection.extend({
		model: mEvent,
		url: 'api/events'
	});
});