define (require) ->
	'model':
		'title': 'Brand and model'
		'span': 6
		'input':
			'type': 'textinput'
		'validation': 
			'required': true
	'numberplate':
		'title': 'Numberplate'
		'span': 6
		'input':
			'type': 'textinput'
		'validation': 
			'required': true
	'initial_mileage':
		'title': 'Initial mileage'
		'span': 6
		'input':
			'type': 'textinput'
		'validation': 
			'required': true
	'access':
		'title': 'Who has access?'
		'span': 6
		'input':
			'type': 'accesslist'
			'collection': ['person', 'group']