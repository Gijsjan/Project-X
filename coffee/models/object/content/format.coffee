define (require) ->
	_ = require 'underscore'
	mContent = require 'models/object/content/content'
	cInputTableRows = require 'collections/input/tablerow'
	hlpr = require 'helper'

	class mFormat extends mContent

		'data':
			'type': 'content/format'
			'title': ''
			'description': ''
			'goal': ''
			'tone_of_voice': ''
			'competition': ''
			'unique_selling_points': ''
			'participation': ''
			'success_factors': ''
			'monitoring': ''
			'financing': ''

		'xdata':
			'age': new cInputTableRows
			'education': new cInputTableRows
			'living': new cInputTableRows
			'sex': new cInputTableRows
			'profession': new cInputTableRows
			'deliverables': new cInputTableRows
			'media': new cInputTableRows
			'partners': new cInputTableRows
			'duration': new cInputTableRows
			'targets': new cInputTableRows
			'capacity': new cInputTableRows
			'costs': new cInputTableRows
			'producers': new cInputTableRows

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

			for own attr, value of attrs
				if (@xdata.hasOwnProperty(attr)) and not (attrs[attr] instanceof cInputTableRows)
					attrs[attr] = new cInputTableRows value

			super

		sync: (method, model, options) ->
			# console.log 'mFormat.sync()'

			# console.log method
			# console.log hlpr.deepCopy model
			# console.log options
			m = @modelManager.models.get(@id)
			if method is 'read' and m?
				options.success(m)
			else
				Backbone.sync(method, model, options)