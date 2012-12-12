BaseModel = require './base'
user = require './people/user'

class Content extends BaseModel
	
	'defaults':
		'type': 'content'
		'title': ''

	'relations':
		'owners': 'attached'
		'editors': 'attached'
		'readers': 'attached'
		'organisations': 'attached'
		'departments': 'attached'
		'projects': 'attached'
		'comments': 'separate'

	initialize: ->
		console.log user.toJSON()
		# if @isNew()


module.exports = Content