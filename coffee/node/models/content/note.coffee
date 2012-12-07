BaseModel = require '../base'

class Note extends BaseModel
	
	'defaults':
		'type': 'notes'
		'title': ''
		'body': ''

	'relations':
		'owners': 'attached'
		'editors': 'attached'
		'readers': 'attached'
		'departments': 'attached'
		'organisations': 'attached'
		'projects': 'attached'
		'comments': 'separate'

module.exports = Note