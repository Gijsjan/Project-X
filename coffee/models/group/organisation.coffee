define (require) ->
	BaseModel = require 'models/base'

	class mOrganisation extends BaseModel

		'urlRoot': '/b/db/organisations'
		
		'defaults':
			'type': 'organisations'
			'title': ''

		'relations':
			'departments': []
			'people': []