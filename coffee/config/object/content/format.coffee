define (require) ->
	'age':
		'title': 'Age'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'range'
			'span': 2
			'input':
				'type': 'rowoptions'
				'options': ['15 - 19y', '20 - 24y', '25 - 30y']
		]
	'capacity':
		'title': 'Capacity'
		'addrows': true
		'columns': [
			'key': 'role'
			'heading': 'Role'
			'span': 4
			'input':
				'type': 'textarea'
		,
			'key': 'departement'
			'heading': 'Departement'
			'span': 4
			'input': 
				'type': 'typeahead'
				'dbview': 'group/departements'
		,
			'key': 'hours'
			'heading': 'Hours'
			'span': 2
			'input':
				'type': 'textarea'
		]
	'competition':
		'title': 'Competition'
		'addrows': false
		'columns': [
			'key': 'competition'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'costs':
		'title': 'Costs'
		'addrows': true
		'columns': [
			'key': 'description'
			'heading': 'Type'
			'span': 6
			'input':
				'type': 'textarea'
		,
			'key': 'amount'
			'heading': 'Amount'
			'span': 2
			'input':
				'prepend': '€'
				'type': 'text'
				'append': ',-'
		,
			'key': 'frequency'
			'heading': 'Frequency'
			'span': 2
			'input':
				'type': 'select'
				'options': ['Once', 'Per month', 'Per year']
		]
	'countries':
		'title': 'Countries'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'country'
			'span': 2
			'input': 
				'type': 'typeahead'
				'dbview': 'object/countries'
		]
	'deliverables':
		'title': 'Deliverables'
		'addrows': true
		'columns': [
			'key': 'product'
			'heading': 'Product'
			'span': 5
			'input':
				'type': 'textarea'
		,
			'key': 'description'
			'heading': 'Description'
			'span': 5
			'input':
				'type': 'textarea'
		]
	'description':
		'title': 'Description'
		'addrows': false
		'columns': [
			'key': 'description'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'duration':
		'title': 'Duration'
		'addrows': true
		'columns': [
			'key': 'scope'
			'heading': 'Scope'
			'span': 5
			'input':
				'type': 'textarea'
		,
			'key': 'duration'
			'heading': 'Duration'
			'span': 5
			'input':
				'type': 'textarea'
		]
	'education':
		'title': 'Education'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'education'
			'span': 2
			'input':
				'type': 'rowoptions'
				'options': ['primary/none', 'secondary', 'university']
		]
	'effects':
		'title': 'Effects'
		'addrows': false
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'effect'
			'span': 9
			'input':
				'type': 'rowoptions'
				'options': ['The target group gets more insight into the topic', 
							'The target group is contemplating the topic', 
							'The target group gets more understanding of different perspectives on the theme',
							'The threshold to discuss the topic is lowered for the target group',
							'The target group feels encouraged to express an opinion on the topic',
							'The target group discusses the topic with others',
							'The target group participates in discussions on the topic']
		]
	'financing':
		'title': 'Financing'
		'addrows': false
		'columns': [
			'key': 'financing'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'goal':
		'title': 'Goal'
		'addrows': false
		'columns': [
			'key': 'goal'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'languages':
		'title': 'Languages'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'language'
			'span': 2
			'input':
				'type': 'rowoptions'
				'options': ['Arabic', 'Chinese', 'English', 'French', 'Spanish']
		]
	'living':
		'title': 'Living'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'living'
			'span': 2
			'input':
				'type': 'rowoptions'
				'options': ['urban', 'rural']
		]
	'media':
		'title': 'Media'
		'addrows': true
		'columns': [
			'key': 'media_type'
			'heading': 'Type'
			'span': 2
			'input':
				'type': 'textarea'
		,
			'key': 'name'
			'heading': 'Name'
			'span': 4
			'input':
				'type': 'textarea'
		,
			'key': 'description'
			'heading': 'Description'
			'span': 4
			'input':
				'type': 'textarea'
		]
	'monitoring':
		'title': 'Monitoring'
		'addrows': false
		'columns': [
			'key': 'monitoring'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'objectives':
		'title': 'Objectives'
		'addrows': false
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'objective'
			'span': 9
			'input':
				'type': 'rowoptions'
				'options': ['Contribute to freedom of speech', 'Contribute to freedom of expression', 'Contribute to free access to diverse informtion']
		]
	'participation':
		'title': 'Participation'
		'addrows': false
		'columns': [
			'key': 'participation'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'partners':
		'title': 'Partners'
		'addrows': true
		'columns': [
			'key': 'partner'
			'heading': 'Partner'
			'span': 4
			'input':
				'type': 'textarea'
		,
			'key': 'country'
			'heading': 'Country'
			'span': 2
			'input': 
				'type': 'typeahead'
				'dbview': 'object/countries'
		,
			'key': 'role'
			'heading': 'Role'
			'span': 4
			'input':
				'type': 'textarea'
		]
	'producers':
		'title': 'Producers'
		'addrows': true
		'columns': [
			'key': 'percentage'
			'heading': '%'
			'span': 1
			'input':
				'type': 'textarea'
				'constrain': 'percentage'
			'relation': 
				'type': 'sum'
				'max': 100
		,
			'key': 'producer'
			'heading': 'Origin'
			'span': 9
			'input':
				'type': 'rowoptions'
				'options': [
					'RNW production' 
					'Co-production with (prio)partners'
					'Content curation (third party content)'
					'User Generated Content'
				]
		]
	'profession':
		'title': 'Profession'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'profession'
			'span': 2
			'input':
				'type': 'rowoptions'
				'options': ['politicians', 'civil servants', 'teachers', 'students', 'farmers', 'journalists', 'lawyer', 'businessmen']
		]
	'sex':
		'title': 'Sex'
		'addrows': true
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'sex'
			'span': 2
			'input':
				'type': 'rowoptions'
				'options': ['men', 'women']
		]
	'success_factors':
		'title': 'Success factors'
		'addrows': false
		'columns': [
			'key': 'success_factors'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'title':
		'title': 'Title'
		'addrows': false
		'columns': [
			'key': 'title'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'tone_of_voice':
		'title': 'Tone of voice'
		'addrows': false
		'columns': [
			'key': 'tone_of_voice'
			'span': 6
			'input':
				'type': 'textarea'
		]
	'topics':
		'title': 'Topics'
		'addrows': false
		'columns': [
			'key': 'importance'
			'span': 1
			'input':
				'type': 'select'
				'options': ['A', 'B', 'C', 'U']
		,
			'key': 'topics'
			'span': 9
			'input':
				'type': 'rowoptions'
				'options': ['Democracy and Good Governance', 'Human Rights', 'Sexual Rights']
		]
	'targets':
		'title': 'Targets'
		'addrows': true
		'columns': [
			'key': 'target_type'
			'heading': 'Type'
			'span': 6
			'input':
				'type': 'textarea'
		,
			'key': 'value'
			'heading': 'Value'
			'span': 4
			'input':
				'type': 'textarea'
		]
	'unique_selling_points':
		'title': 'Unique selling points'
		'addrows': false
		'columns': [
			'key': 'unique_selling_points'
			'span': 6
			'input':
				'type': 'textarea'
		]