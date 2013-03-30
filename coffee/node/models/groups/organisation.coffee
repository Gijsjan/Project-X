Group = require '../group'

class Organisation extends Group
	
	'defaults':
		'type': 'organistions'
		'title': ''

	'relations':
		'people': 'separate'
		'departments': 'attached'

module.exports = Organisation