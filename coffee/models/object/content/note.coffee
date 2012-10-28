define (require) ->
	_ = require 'underscore'
	BaseModel = require 'models/base'
	mContent = require 'models/object/content/content'

	class mNote extends BaseModel

		'urlRoot': '/b/db/notes'
		
		'defaults':
			'title': ''
			'body': ''