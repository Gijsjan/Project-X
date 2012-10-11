define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	hlpr = require 'helper'

	class mObject extends Backbone.Model

		'urlRoot': '/api/object'

		'defaults':
			'type': ''
			'created': ''
			'updated': ''

		'show': true

		validate: (attrs) ->
			response = {}
			response.validationerrors = {}

			for own key, value of @validation
				if value.required and $.trim(attrs[key]) is ''
					response.validationerrors[key] = value.message
			
			if _.isEmpty response.validationerrors
				return undefined
			else
				return response
		
		# initialize: ->
			#@on 'change', @saveToLocalStorage, @

		###
		saveToLocalStorage: (model, options) ->
			Models = require 'switchers/models'

			localAttrs = {}
			if localStorage[Backbone.history.fragment]?
				localAttrs = JSON.parse(localStorage[Backbone.history.fragment]) 
				localAttrs = new Models[localAttrs.type](localAttrs).attributes # Create new model to invoke the extended set(attributes, options)

			thisAttrs = model.toJSON()

			# Compare the (cloned) models without the 'updated' attribute
			delete localAttrs.updated
			delete thisAttrs.updated

			if not _.isEqual thisAttrs, localAttrs
				data = 'updated': hlpr.date2datetime(new Date())
				model.set data, 'silent': true
				localStorage[Backbone.history.fragment] = JSON.stringify model
		###
