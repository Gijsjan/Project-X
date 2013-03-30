define (require) ->
	'title':
		'title': 'Title'
		'span': 6
		'input':
			'type': 'textinput'
		'validation': 
			'required': true
	'body':
		'title': 'Body'
		'span': 6
		'input':
			'type': 'textarea'
		'validation': 
			'required': true
	'access':
		'title': 'Who has access?'
		'span': 6
		'input':
			'type': 'accesslist'
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