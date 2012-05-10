define([
	'backbone',
	'models/video'
], function(Backbone, mVideo) {
	return Backbone.Collection.extend({
		model: mVideo,
		url: 'api/videos'
	});
});