define (require) ->
	BaseModel = require 'models/base'

	class mDepartment extends BaseModel

		'urlRoot': '/b/db/departments'
		
		'defaults':
			'type': 'departments'
			'title': ''

		'relations':
			'people': []