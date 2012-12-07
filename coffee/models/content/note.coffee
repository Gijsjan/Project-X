define (require) ->
	# _ = require 'underscore'
	BaseModel = require 'models/base'
	# mContent = require 'models/content'

	class mNote extends BaseModel

		'urlRoot': '/b/db/notes'
		
		'defaults':
			'type': 'notes'
			'title': ''
			'body': ''
			'owner': ''