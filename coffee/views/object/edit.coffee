# @options.className - setting dynamicly in the view is cleaner, but this is not (yet?) possible
# @options.model - with id argument if id? else default model
# @options.id - only if id?

define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	Models = require 'switchers/models'
	EditTemplates = require 'switchers/templates.edit'
	helper = require 'helper'

	class vEditObject extends BaseView
		
		events:
			"keyup input.bind": "onInputKeyup"
			"keyup select.bind": "onInputKeyup"
			"keyup textarea": "onTextareaKeyup"

			"change input.bind": "onInputChanged"
			"change textarea.bind": "onInputChanged"
			"change select.bind": "onInputChanged"
			
			"click #sSubmit": "saveObject"
			"click label[for=title]": "getInfo"

		getInfo: ->
			console.log @model.attributes

		onInputKeyup: (e) ->
			if e.keyCode is 13
				@saveObject()

		onTextareaKeyup: (e) ->
			target = $(e.currentTarget)
			target.height(24) # arbitrary number 36 is approx 2 lines, if not set, the textarea will not autoresize on backspace
			target.height target[0].scrollHeight # Set height to 1 first cuz scrollHeight is not adjusted when value decreases (ie when user removes lines)
		
		onInputChanged: (e) ->
			@model.set e.target.id, e.target.value, 'silent': true # update the model with a new value

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
					error: (model, response) =>
						@navigate 'login' if response.status is 401 

			super

		render: ->
			tpl = EditTemplates[@model.get 'type']

			html = _.template tpl, @model.toJSON()

			@$el.html html
			
			@
		
		saveObject: ->
			@model.save {},
				success: (model, response) =>
					@trigger 'done', model
				error: (model, response) =>
					if response.status is 401
						@navigate 'login'
					else if response.validationerrors?
						console.log response.validationerrors # debugging
						@onValidationErrors response.validationerrors
					else
						console.log model
						console.log response

		onValidationErrors: (errors) ->
			@$('.error').removeClass 'error' # remove all error classes

			for own key, value of errors # loop over errors
				@addValidationError key

		addValidationError: (key) ->
			@$('#'+key).addClass 'error' # add error class to input, textarea and select
			@$('label[for='+key+']').addClass 'error' # add eror class to label


			#false # is this necessary?