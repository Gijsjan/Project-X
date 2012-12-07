BaseModel = require './base'

class Organisation extends BaseModel
	
	'defaults':
		'type': 'organistions'
		'title': ''

	'relations':
		'people': 'separate'
		'departments': 'attached'

module.exports = Organisation