define([
	'underscore',
	'backbone',
	'switchers/models'
], function(_, Backbone, Models) {
	return Backbone.Collection.extend({
		url: '/api/contentlist',
		model: function(attributes, options) {
			var model = (!attributes.type) ? Backbone.Model() : Models[attributes.type];
			return new model(attributes, options); //get the correct model from ModelsController
		}
	});
});