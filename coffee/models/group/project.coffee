define (require) ->
	BaseModel = require 'models/base'

	class mProject extends BaseModel

		'urlRoot': '/b/db/projects'
		
		'type': 'projects'
		
		'defaults':
			'title': ''