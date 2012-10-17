define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	hlpr = require 'helper'

	class mObject extends Backbone.Model

		'urlRoot': '/api/object'

		'defaults':
			'_id': ''
			'_rev': ''
			'type': ''
			'created': ''
			'updated': ''

		parse: (response) ->
			# console.log 'mObject.parse()'

			if response.rev? # if response is document than _rev is present, on update rev is present
				response._rev = response.rev
				delete response.rev

			response.id = response._id if response._id?

			response

		validate: (attrs) ->
			# console.log 'mObject.validate()'

			# FOR DEBUGGING ONLY? or should the type always be checked? or check in db?
			for own key, value of attrs
				if typeof @defaults[key] isnt typeof value and key isnt 'id' and key isnt 'ok'
					console.log(key + ' ' + typeof @defaults[key] + ' ' + typeof value)
					throw new Error(key + ' ' + typeof @defaults[key] + ' ' + typeof value)
			# FOR DEBU...

			response = {}
			response.validationerrors = {}

			for own key, value of @validation
				if value.required and $.trim(attrs[key]) is ''
					response.validationerrors[key] = value.message

			if _.isEmpty response.validationerrors
				return undefined
			else
				console.log response
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
