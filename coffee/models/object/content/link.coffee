define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'

	class mLink extends mContent
		
		'defaults': _.extend({}, mContent.prototype.defaults,
			'type': 'content/link'
			'title': ''
			'address': ''
			'possible_titles': [] )