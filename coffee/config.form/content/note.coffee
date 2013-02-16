define (require) ->
	'title':
		'title': 'Title'
		'span': 6
		'input':
			'type': 'textinput'
	'body':
		'title': 'Body'
		'span': 6
		'input':
			'type': 'textarea'
	'access':
		'title': 'Who has access?'
		'span': 6
		'input':
			'type': 'editablelist'
			'collection': ['person', 'group']
	# 'users':
	# 	'title': 'Users'
	# 	'span': 6
	# 	'input':
	# 		'type': 'editablelist'
	# 		'collection': 'person'
	# 'groups':
	# 	'title': 'Groups'
	# 	'span': 6
	# 	'input':
	# 		'type': 'editablelist'
	# 		'collection': 'group'