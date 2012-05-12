define([
	'underscore',
	'backbone',
	'models/content'
], function(_, Backbone, mContent){
	return mContent.extend({
		'urlRoot': '/api/document',
		'defaults': _.extend({}, mContent.prototype.defaults, {
			'type': 'document',
			'filename': '',
			'filesize': 0,
			'title': '',
			'author': '',
			'pages': 0,
			'newtags': []
		})
	});
});

