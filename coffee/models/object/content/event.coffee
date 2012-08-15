define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'

	mContent.extend
	
		'urlRoot': '/api/event'
		
		'defaults': _.extend({}, mContent.prototype.defaults,
			'type': 'event'
			'title': ''
			'description': ''
			'address': ''
			'city': ''
			'start': ''
			'end': '' )