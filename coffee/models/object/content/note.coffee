define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'

	class mNote extends mContent
		
		defaults: _.extend({}, mContent::defaults,
			'type': 'content/note'
			'title': ''
			'body': '')