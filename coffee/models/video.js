define([
	'underscore',
	'backbone',
	'models/content'
], function(_, Backbone, mContent){
	return mContent.extend({
		'urlRoot': '/api/video',
		'defaults': _.extend({}, mContent.prototype.defaults, {
			'type': 'video'
		})
	});
});

