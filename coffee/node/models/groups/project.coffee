Group = require '../group'

class Project extends Group
	
	'defaults':
		'type': 'projects'
		'title': ''

	'relations':
		'people': 'separate'
		'departments': 'attached'
		'organisations': 'attached'

module.exports = Project