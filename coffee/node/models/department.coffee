BaseModel = require './base'

class Department extends BaseModel
	
	'defaults':
		'type': 'departments'
		'title': ''

	'relations':
		'people': 'separate'
		'organisations': 'attached'

module.exports = Department