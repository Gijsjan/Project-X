define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'
	cInputTableRow = require 'collections/input/tablerow'
	hlpr = require 'helper'

	class mFormat extends mContent

		'data':
			'type': 'content/format'


		'xdata':
			'title': ""
			'competition': new cInputTableRow
			'description': new cInputTableRow
			'financing': new cInputTableRow
			'goal': new cInputTableRow
			'monitoring': new cInputTableRow
			'participation': new cInputTableRow
			'success_factors': new cInputTableRow
			'tone_of_voice': new cInputTableRow
			'unique_selling_points': new cInputTableRow

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
			'targets': new cInputTableRow

		defaults: ->
			data = _.extend {}, @data, @xdata
			_.extend {}, mContent::defaults, data

		set: (attrs, options) ->
			# console.log 'mFormat.set()'

			# If model.set('attr', 'options') is used instead of model.set({attr: options}) attrs is a string
			# For the loop to work, attrs has to be an object
			if _.isString(attrs)
				data = {}
				data[attrs] = options
				attrs = data

			# for own attr, value of attrs
			# 	if (@xdata.hasOwnProperty(attr)) and not (attrs[attr] instanceof cInputTableRow)
			# 		attrs[attr] = new cInputTableRow value

			super

		sync: (method, model, options) ->
			# console.log 'mFormat.sync()'

			m = @modelManager.models[@id]
			if method is 'read' and m?
				options.success(m)
			else
				Backbone.sync(method, model, options)