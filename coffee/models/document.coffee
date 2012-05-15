define [
		'underscore',
		'backbone',
		'models/content'
	], (_, Backbone, mContent) ->
		mContent.extend
			urlRoot: '/api/document'
			defaults: _.extend({}, mContent.prototype.defaults,
				'type': 'document'
				'filename': ''
				'filesize': 0
				'title': ''
				'author': ''
				'pages': 0
			)
			set: (attributes, options) ->
				mContent.prototype.set.call this, attributes, options