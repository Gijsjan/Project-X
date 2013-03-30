define (require) ->
	BaseModel = require 'models/base'

	class mDepartment extends BaseModel

		'urlRoot': '/b/db/departments'
		
		'type': 'departments'
		
		'defaults':
			'title': ''

		'relations':
			'people': []