define (require) ->
	BaseModel = require 'models/base'
	cPerson = require 'collections/people'

	class GroupMin extends BaseModel

		'type': 'group'

		'type_ids':
			'department': '1'
			'organisation': '2'
			'project': '3'
			'family': '4'

		'defaults':	_.extend({}, BaseModel::defaults, 
			'title': ''
			'type': 'group'
			'group_type':
				'id': ''
				'value': ''
			'created': ''
			'updated': '')