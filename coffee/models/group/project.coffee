define (require) ->
	# _ = require 'underscore'
	BaseModel = require 'models/base'
	# mContent = require 'models/content'

	class mProject extends BaseModel

		'urlRoot': '/b/db/projects'
		
		'defaults':
			'type': 'projects'
			'title': ''