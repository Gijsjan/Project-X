define([
	'underscore',
	'backbone',
	'models/content'
], function(_, Backbone, mContent){
	return mContent.extend({
		'urlRoot': '/api/link',
		'defaults': _.extend({}, mContent.prototype.defaults, {
			'type': 'link',
			'title': '',
			'address': '',
			'possible_titles': []
		})
	});
});

