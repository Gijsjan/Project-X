define (require) ->
	'title':
		'title': 'Title'
		'span': 3
		'input':
			'type': 'textinput'
	'departments':
		'title': 'Departments'
		'span': 3
		'input': 
			'type': 'editablelist'
			'dbview': 'departments'
	'people':
		'title': 'Members'
		'span': 3
		'input': 
			'type': 'editablelist'
			'dbview': 'people'