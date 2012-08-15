define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'

	mContent.extend

		urlRoot: '/api/note'
		
		defaults: _.extend({}, mContent.prototype.defaults,
			'type': 'note'
			'title': ''
			'body': '')