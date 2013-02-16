define (require) ->
	'title':
		'title': 'Title'
		'span': 6
		'input':
			'type': 'textinput'
	'type':
		'title': 'Type'
		'span': 6
		'input':
			'type': 'select'
			'url': '/b/db/group/type'
	'members':
		'title': 'Members'
		'span': 6
		'input':
			'type': 'editablelist'
			'collection': 'person'