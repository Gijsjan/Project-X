define (require) ->
	'age':
		'addrows': true
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'range'
			'width': 95
			'input':
				'type': 'options'
				'options': ['15 - 19y', '20 - 24y', '25 - 30y']
		]
	'capacity':
		'addrows': true
		'columns': [
			'key': 'role'
			'heading': 'Role'
			'width': 40
			'input':
				'type': 'text'
		,
			'key': 'departement'
			'heading': 'Departement'
			'width': 40
			'input': 
				'type': 'autocomplete'
				'dbview': 'group/departements'
		,
			'key': 'hours'
			'heading': 'Hours/week'
			'width': 20
			'input':
				'type': 'text'
		,
		]
	'costs':
		'addrows': true
		'columns': [
			'key': 'description'
			'heading': 'Type'
			'width': 60
			'input':
				'type': 'text'
		,
			'key': 'amount'
			'heading': 'Amount'
			'width': 20
			'input':
				'type': 'text'
		,
			'key': 'frequency'
			'heading': 'Frequency'
			'width': 20
			'input':
				'type': 'select'
				'options': ['once', 'per month', 'per year']
		]
	'deliverables':
		'addrows': true
		'columns': [
			'key': 'product'
			'heading': 'Product'
			'width': 50
			'input':
				'type': 'text'
		,
			'key': 'description'
			'heading': 'Description'
			'width': 50
			'input':
				'type': 'textarea'
		]
	'duration':
		'addrows': true
		'columns': [
			'key': 'scope'
			'heading': 'Scope'
			'width': 50
			'input':
				'type': 'text'
		,
			'key': 'duration'
			'heading': 'Duration'
			'width': 50
			'input':
				'type': 'text'
		]
	'education':
		'addrows': true
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'education'
			'width': 95
			'input':
				'type': 'options'
				'options': ['primary/none', 'secondary', 'university']
		]
	'effects':
		'addrows': false
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'effect'
			'width': 95
			'input':
				'type': 'options'
				'options': ['The target group gets more insight into the topic', 
							'The target group is contemplating the topic', 
							'The target group gets more understanding of different perspectives on the theme',
							'The threshold to discuss the topic is lowered for the target group',
							'The target group feels encouraged to express an opinion on the topic',
							'The target group discusses the topic with others',
							'The target group participates in discussions on the topic']
		]
	'living':
		'addrows': true
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'living'
			'width': 95
			'input':
				'type': 'options'
				'options': ['urban', 'rural']
		]
	'media':
		'addrows': true
		'columns': [
			'key': 'media_type'
			'heading': 'Type'
			'width': 30
			'input':
				'type': 'text'
		,
			'key': 'name'
			'heading': 'Name'
			'width': 30
			'input':
				'type': 'text'
		,
			'key': 'description'
			'heading': 'Description'
			'width': 40
			'input':
				'type': 'textarea'
		]
	'objectives':
		'addrows': false
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'objective'
			'width': 95
			'input':
				'type': 'options'
				'options': ['Contribute to freedom of speech', 'Contribute to freedom of expression', 'Contribute to free access to diverse informtion']
		]
	'partners':
		'addrows': true
		'columns': [
			'key': 'partner'
			'heading': 'Partner'
			'width': 40
			'input':
				'type': 'text'
		,
			'key': 'country'
			'heading': 'Country'
			'width': 20
			'input': 
				'type': 'autocomplete'
				'dbview': 'object/countries'
		,
			'key': 'role'
			'heading': 'Role'
			'width': 40
			'input':
				'type': 'text'
		]
	'profession':
		'addrows': true
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'profession'
			'width': 95
			'input':
				'type': 'options'
				'options': ['politicians', 'civil servants', 'teachers', 'students', 'farmers', 'journalists', 'lawyer', 'businessmen']
		]
	'sex':
		'addrows': true
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'sex'
			'width': 95
			'input':
				'type': 'options'
				'options': ['men', 'women']
		]
	'topics':
		'addrows': false
		'columns': [
			'key': 'importance'
			'width': 5
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'topics'
			'width': 95
			'input':
				'type': 'options'
				'options': ['Democracy and Good Governance', 'Human Rights', 'Sexual Rights']
		]
	'producers':
		'addrows': true
		'columns': [
			'key': 'percentage'
			'heading': '%'
			'width': 10
			'input':
				'type': 'text'
				'constrain': 'percentage'
			'relation': 
				'type': 'sum'
				'max': 100
		,
			'key': 'producer'
			'heading': 'Origin'
			'width': 90
			'input':
				'type': 'options'
				'options': [
					'RNW production' 
					'Co-production with (prio)partners'
					'Content curation (third party content)'
					'User Generated Content'
				]
		]
	'targets':
		'addrows': true
		'columns': [
			'key': 'target_type'
			'heading': 'Type'
			'width': 60
			'input':
				'type': 'text'
		,
			'key': 'value'
			'heading': 'Value'
			'width': 40
			'input':
				'type': 'text'
		]			