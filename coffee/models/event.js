define([
	'underscore',
	'backbone',
	'models/content'
], function(_, Backbone, mContent){
	return mContent.extend({
		'urlRoot': '/api/event',
		'defaults': _.extend({}, mContent.prototype.defaults, {
			'type': 'event'
		})
	});
});

