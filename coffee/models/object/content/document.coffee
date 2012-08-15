define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'

	mContent.extend

		urlRoot: '/api/document'
		
		defaults: _.extend({}, mContent.prototype.defaults,
			'type': 'document'
			'filename': ''
			'filesize': 0
			'title': ''
			'author': ''
			'pages': 0)