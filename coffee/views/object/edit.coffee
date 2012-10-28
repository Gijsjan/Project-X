# @options.className - setting dynamicly in the view is cleaner, but this is not (yet?) possible
# @options.model - with id argument if id? else default model
# @options.id - only if id?

define (require) ->
	# $ = require 'jquery'
	# _ = require 'underscore'
	# Backbone = require 'backbone'
	BaseView = require 'views/base'
	# Models = require 'switchers/models'
	EditTemplates = require 'switchers/templates.edit'
	# vModal = require 'views/main/modal'
	# vLogin = require 'views/main/login'
	helper = require 'helper'

	class vEditObject extends BaseView
		
		events:
			"keyup input.bind": "onInputKeyup"
			"keyup select.bind": "onInputKeyup"
			"keyup textarea": "onTextareaKeyup"

			"change input.bind": "onInputChanged"
			"change textarea.bind": "onInputChanged"
			"change select.bind": "onInputChanged"
			
			"click button.save": "saveObject"

		onInputKeyup: (e) ->
			if e.keyCode is 13
				@saveObject()

		onTextareaKeyup: (e) ->
			target = $(e.currentTarget)
			target.height(20) # arbitrary number 36 is approx 2 lines, if not set, the textarea will not autoresize on backspace
			target.height target[0].scrollHeight # Set height to 1 first cuz scrollHeight is not adjusted when value decreases (ie when user removes lines)
		
		onInputChanged: (e) ->
			@model.set e.target.id, e.target.value, 'silent': true # update the model with a new value

		saveObject: (e) ->
			console.log 'vEditObject.saveObject()'

			@model.save {},
				success: (model, response) =>
					@globalEvents.trigger 'modelSaved', model
				error: (collection, response) => @globalEvents.trigger response.status+''

			false
		
		initialize: ->
			@model.on 'validated', (errors) ->
				console.log errors

			if @model.isNew()
				@render()
			else
				# PUT MODEL FETCH IN MODEL WITH A CALLBACK ARGUMENT ?
				@model.fetch
					success: (model, response) =>
						@render()
					error: (model, response) => @globalEvents.trigger response.status+''

			super

		render: ->
			# console.log 'vEditObject.render()'
			tpl = EditTemplates[@model.get('bucket')]
			console.log @model
			html = _.template tpl, @model.toJSON()

			@$el.html html
			
			@
		

		onValidationErrors: (errors) ->
			@$('.error').removeClass 'error' # remove all error classes

			for own key, value of errors # loop over errors
				@addValidationError key

		addValidationError: (key) ->
			@$('#'+key).addClass 'error' # add error class to input, textarea and select
			@$('label[for='+key+']').addClass 'error' # add eror class to label