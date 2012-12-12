define (require) ->
	BaseModel = require 'models/base'

	class Note extends BaseModel

		'urlRoot': '/b/db/notes'
		
		'defaults':
			'type': 'notes'
			'title': ''
			'body': ''
		
		'relations':
			'owners': []
			'editors': []
			'readers': []
			'organisations': []
			'departments': []
			'projects': []
			'comments': []