define (require) ->
	BaseModel = require 'models/base'

	class ContentMin extends BaseModel
		
		'type': 'content'
		
		'defaults':	_.extend({}, BaseModel::defaults, 
			'title': ''
			'type':
				'id': ''
				'value': '')