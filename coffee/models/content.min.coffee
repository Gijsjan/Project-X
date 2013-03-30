define (require) ->
	BaseModel = require 'models/base'

	class ContentMin extends BaseModel
		
		'type': 'content'

		'type_ids':
			'note': '1'
			'document': '2'
			'todo': '3'
			'carpool': '4'

		initialize: ->
			@set 'content_type', 
				'id': @type_ids[@type]
				'value': @type
	
		defaults: -> _.extend({}, BaseModel::defaults, 
			'title': ''
			'type': 'content'
			'content_type':
				'id': ''
				'value': ''
			'created': ''
			'updated': '')