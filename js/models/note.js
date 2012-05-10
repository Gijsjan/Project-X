define([
	'underscore',
	'backbone',
	'models/content'
], function(_, Backbone, mContent){
	return mContent.extend({
		urlRoot: '/api/note',
		defaults: _.extend({}, mContent.prototype.defaults, {
			'type': 'note',
			'title': '',
			'body': ''
		})
	});
});

