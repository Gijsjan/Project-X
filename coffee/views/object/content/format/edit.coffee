define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditContent = require 'views/object/content/edit'
	vPagination = require 'views/main/pagination.pages'
	vInputTable = require 'views/input/table'

	class vEditFormat extends vEditContent

		render: ->
			super

			@pgn = new vPagination
				parent: @
				hash: @options.hash
			@on 'hashchange', @pgn.changePage, @pgn # Change page when window.onhashchange is triggerd in app.js

			age = new vInputTable
				'attribute': 'age'
				'rows': @model.get 'age'
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
			age.on 'data changed', @updateModel, @
			@$('div.age').html age.render().$el

			capacity = new vInputTable
				'attribute': 'capacity'
				'rows': @model.get 'capacity'			
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
						'view': 'group/departements'
				,
					'key': 'hours'
					'heading': 'Hours/week'
					'width': 20
					'input':
						'type': 'text'
				,
				]
			capacity.on 'data changed', @updateModel, @
			@$('div.capacity').html capacity.render().$el

			costs = new vInputTable
				'attribute': 'costs'
				'rows': @model.get 'costs'
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
			costs.on 'data changed', @updateModel, @
			@$('div.costs').html costs.render().$el

			deliverables = new vInputTable
				'attribute': 'deliverables'
				'rows': @model.get 'deliverables'
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
			deliverables.on 'data changed', @updateModel, @
			@$('div.deliverables').html deliverables.render().$el

			duration = new vInputTable
				'attribute': 'duration'
				'rows': @model.get 'duration'			
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
			duration.on 'data changed', @updateModel, @
			@$('div.duration').html duration.render().$el

			education = new vInputTable
				'attribute': 'education'
				'rows': @model.get 'education'				
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
			education.on 'data changed', @updateModel, @
			@$('div.education').html education.render().$el


			effects = new vInputTable
				'attribute': 'effects'
				'rows': @model.get 'effects'
				'addrows': true
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
			effects.on 'data changed', @updateModel, @
			@$('div.effects').html effects.render().$el

			living = new vInputTable
				'attribute': 'living'
				'rows': @model.get 'living'	
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
			living.on 'data changed', @updateModel, @
			@$('div.living').html living.render().$el

			media = new vInputTable
				'attribute': 'media'
				'rows': @model.get 'media'
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
			media.on 'data changed', @updateModel, @
			@$('div.media').html media.render().$el

			objectives = new vInputTable
				'attribute': 'objectives'
				'rows': @model.get 'objectives'
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
			objectives.on 'data changed', @updateModel, @
			@$('div.objectives').html objectives.render().$el

			partners = new vInputTable
				'attribute': 'partners'
				'rows': @model.get 'partners'			
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
						'view': 'object/countries'
				,
					'key': 'role'
					'heading': 'Role'
					'width': 40
					'input':
						'type': 'text'
				]
			partners.on 'data changed', @updateModel, @
			@$('div.partners').html partners.render().$el

			profession = new vInputTable
				'attribute': 'profession'
				'rows': @model.get 'profession'
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
			profession.on 'data changed', @updateModel, @
			@$('div.profession').html profession.render().$el

			sex = new vInputTable
				'attribute': 'sex'
				'rows': @model.get 'sex'
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
			sex.on 'data changed', @updateModel, @
			@$('div.sex').html sex.render().$el

			topics = new vInputTable
				'attribute': 'topics'
				'rows': @model.get 'topics'
				'addrows': true
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
			topics.on 'data changed', @updateModel, @
			@$('div.topics').html topics.render().$el

			producers = new vInputTable
				'attribute': 'producers'
				'rows': @model.get 'producers'				
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
			producers.on 'data changed', @updateModel, @
			@$('div.producers').html producers.render().$el

			targets = new vInputTable
				'attribute': 'targets'
				'rows': @model.get 'targets'		
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
			targets.on 'data changed', @updateModel, @
			@$('div.targets').html targets.render().$el

			_.each $('textarea'), (textarea) -> $(textarea).height textarea.scrollHeight # set the proper heights for textarea's

		updateModel: (x) ->
			@model.set x.attr, x.data