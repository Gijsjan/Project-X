Group = require '../group'

class Department extends Group
	
	'defaults':
		'type': 'departments'
		'title': ''

	'relations':
		'people': 'separate'
		'organisations': 'attached'

module.exports = Department