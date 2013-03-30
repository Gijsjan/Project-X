define (require) ->
	BaseCollection = require 'collections/base'
	mContent = require 'models/content.min'

	class Content extends BaseCollection

		model: mContent
	
		url: '/b/db/content'