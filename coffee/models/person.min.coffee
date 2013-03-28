define (require) ->
	BaseModel = require 'models/base'

	class PersonMin extends BaseModel

		'type': 'person'

		'defaults':	_.extend({}, BaseModel::defaults, 
			'username': ''
			'email': ''
			'type': 'person'
			'created': ''
			'updated': '')

		parse: (attributes) ->
			attributes.title = attributes.username

			attributes