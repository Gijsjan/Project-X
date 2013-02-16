define (require) ->
	BaseModel = require 'models/base'
	cPerson = require 'collections/people'

	class GroupMin extends BaseModel

		'type': 'group'

		'defaults':	_.extend({}, BaseModel::defaults, 
			'title': ''
			'type':
				'id': ''
				'value': '')