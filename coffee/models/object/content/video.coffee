define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'

	mContent.extend

		urlRoot: '/api/video'
		
		defaults: _.extend({}, mContent.prototype.defaults,
			'type': 'video')