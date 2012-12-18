Base = require './base'

class Person extends Base

	'defaults':
		'type': 'people'
		'title': ''
		'email': []

	'relationAttributes': [
		'id'
		'title'
		'email'
	]

	'relations':
		'content': 'separate'
		'departments': 'attached'
		'organisations': 'attached'
		'projects': 'separate'

module.exports = Person