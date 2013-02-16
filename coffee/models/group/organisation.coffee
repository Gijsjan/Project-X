define (require) ->
	BaseModel = require 'models/base'

	class mOrganisation extends BaseModel

		'urlRoot': '/b/db/organisations'
		
		'type': 'organisations'
		
		'defaults':
			'title': ''

		'relations':
			'departments': []
			'people': []