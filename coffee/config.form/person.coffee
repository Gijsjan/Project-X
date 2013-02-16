define (require) ->
	'username':
		'title': 'Username'
		'span': 6
		'input':
			'type': 'textinput'
	'email':
		'title': 'E-mail'
		'span': 6
		'input':
			'type': 'textinput'
	'password':
		'title': 'Password'
		'span': 6
		'input':
			'type': 'textinput'
	'groups':
		'title': 'Groups'
		'span': 6
		'input':
			'type': 'editablelist'
			'collection': 'group'