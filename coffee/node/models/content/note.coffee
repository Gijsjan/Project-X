Content = require '../content'

class Note extends Content
	
	'defaults':
		'type': 'notes'
		'title': ''
		'body': ''

		# 'owners': 'attached'
		# 'editors': 'attached'
		# 'readers': 'attached'
		# 'departments': 'attached'
		# 'organisations': 'attached'
		# 'projects': 'attached'
		# 'comments': 'separate'

module.exports = Note