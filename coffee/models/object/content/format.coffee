define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'
	cInputTableRow = require 'collections/input/tablerow'
	hlpr = require 'helper'

	class mFormat extends mContent

		defaults: _.extend({}, mContent::defaults,
			'type': "content/format"
			'title': ""
			'description': ""
			'goal': ""
			'competition': ""
			'financing': ""
			'monitoring': ""
			'participation': ""
			'success_factors': ""
			'tone_of_voice': ""
			'unique_selling_points': ""
			'shortcut2countries': {}
			'shortcut2departements': {}
			'age': new cInputTableRow
			'capacity': new cInputTableRow
			'costs': new cInputTableRow
			'countries': new cInputTableRow
			'deliverables': new cInputTableRow
			'duration': new cInputTableRow
			'education': new cInputTableRow
			'effects': new cInputTableRow
			'languages': new cInputTableRow
			'living': new cInputTableRow
			'media': new cInputTableRow
			'objectives': new cInputTableRow
			'partners': new cInputTableRow
			'producers': new cInputTableRow
			'profession': new cInputTableRow
			'sex': new cInputTableRow
			'topics': new cInputTableRow
			'targets': new cInputTableRow)


		'validation':
			'title':
				'required': true
				'message': 'Please enter a title!'
			'description':
				'required': true
				'message': 'Please enter a description!'
			'goal':
				'required': true

		set: (attrs, options) ->
			# console.log 'mFormat.set()'

			if attrs.hasOwnProperty('_id') is false

				if attrs.hasOwnProperty 'countries'
					relations = @get('relations')
					relations.country = {} if not relations.country?

					for obj in attrs.countries
						relations.country[obj.country] = {}

					@set 'relations', relations

					# @updateRelations(previous, countries)
					
					# @globalEvents.trigger 'ajaxPut',
					# 	'url': '_design/object/_update/relation/'+row.country.id+'?type=format&id='+@get('id')
					# 	'success': (data) ->
					# 		console.log data
				if attrs.hasOwnProperty 'capacity'
					departements = {}
					for own id, row of attrs.capacity
						departements[row.departement.id] = row.departement if _.isObject row.departement
					@set 'shortcut2departements', departements
			
			# if _.isString(attrs)
				
			# 	# If model.set('attr', 'options') is used instead of model.set({attr: options}) attrs is a string
			# 	# For the loop to work, attrs has to be an object
			# 	# WHAT LOOP? IS THIS STILL NECESSARY?
			# 	data = {}
			# 	data[attrs] = options
			# 	attrs = data

			super

		# MOVE TO BASEMODEL?
		sync: (method, model, options) ->
			# console.log 'mFormat.sync()'

			m = @modelManager.models[@id]
			if method is 'read' and m?
				options.success(m)
			else
				Backbone.sync(method, model, options)