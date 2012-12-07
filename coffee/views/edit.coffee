# @options.className - setting dynamicly in the view is cleaner, but this is not (yet?) possible
# @options.model - with id argument if id? else default model
# @options.id - only if id?

define (require) ->
	# $ = require 'jquery'
	# _ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	ev = require 'EventDispatcher'
	vInputTable = require 'views/input/table'
	Input = require 'views/input/input'
	sEditTemplates = require 'switchers/templates.edit'
	FormConfig = require 'switchers/formconfigs'
	ajax = require 'AjaxManager'
	hlpr = require 'helper'
	# Models = require 'switchers/models'
	# vModal = require 'views/main/modal'
	# vLogin = require 'views/main/login'

	class vEdit extends BaseView
		
		events:
			# "keyup input.bind": "onInputKeyup"
			# "keyup select.bind": "onInputKeyup"
			# "keyup textarea": "onTextareaKeyup"

			# "change input.bind": "onInputChanged"
			# # "change textarea.bind": "onInputChanged"
			# "change select.bind": "onInputChanged"
			
			"click button.save": "saveObject"

		# onInputKeyup: (e) ->
		# 	console.log 'vEdit.onInputKeyup()'
		# 	console.log e.keyCode
		# 	if e.keyCode is 13
		# 		@saveObject()

		# onTextareaKeyup: (e) ->
		# 	target = $(e.currentTarget)
		# 	target.height(20) # arbitrary number 36 is approx 2 lines, if not set, the textarea will not autoresize on backspace
		# 	target.height target[0].scrollHeight # Set height to 1 first cuz scrollHeight is not adjusted when value decreases (ie when user removes lines)
		
		# onInputChanged: (e) ->
		# 	@model.set e.target.id, e.target.value, 'silent': true # update the model with a new value

		saveObject: (e) ->
			@model.set 'relations', @model.relations
			@model.save {},
				success: (model, response) =>
					ev.trigger 'modelSaved', model
				error: (collection, response) => ev.trigger response.status+''

			false
		
		initialize: ->
			# @model.on 'validated', (errors) -> console.log errors
			if @model.isNew() then @render() else
				# PUT MODEL FETCH IN MODEL WITH A CALLBACK ARGUMENT ?
				@model.fetch
					success: (model, response) =>
						@render()
					error: (model, response) => ev.trigger response.status+''

			super

		render: ->
			# console.log 'vEditObject.render()'
			tpl = sEditTemplates[@model.get('type')]
			html = _.template tpl, @model.toJSON()
			@$el.html html

			# @model.getRelations 'success': =>
				# - Loop over the config json to render all vInputTables
			for own key, options of FormConfig[@model.get('type')]
				isRelation = @model.relations.hasOwnProperty(key)

				if not (@model.isNew() and isRelation) # don't show relations when adding new
					
					options.key = key
					options.value = if isRelation then @model.relations[key] else @model.get key
					input = new Input options
					input.on 'valuechanged', (key, value) => @model.set key, value

					@$('section.'+key).html input.$el
			



					# override options.value if the key is a relation, ie: key = members and relations.members exists
					# options.value = @model.relations[key] if @model.relations.hasOwnProperty(key)

				# # All inputs (text, textarea, select, etc) are vInputTables, so plain text has to be turned into an object		
				# if _.isString value
				# 	data = {}
				# 	data[key] = value
				# 	value = data

				# # The vInputTable converts a collection of tablerow data into a table, so the tablevalue is a cInputTableRow
				# # If value is not an cInputTableRow (on server load or new) convert to cInputTableRow
				# value = new Backbone.Collection value if not (value instanceof Backbone.Collection)

				# options = _.extend(configdata, 'tablekey': key, 'tablevalue': value) # Extend the config with tablekey (string) and value (cInputTableRow)

				# inputTable = new vInputTable options
				# inputTable.on 'valuechanged', @updateModelAttributes, @ # If the value (cInputTableRow) changes, set the model
				

			hlpr.delay 0, @adjustTextareas # add delay of 0 to queue the adjusting, see: http://stackoverflow.com/questions/9502774/backbone-js-trigger-an-event-on-a-view-after-the-render

			
			@

		adjustTextareas: ->
			_.each @$('.tab-pane.active textarea'), (textarea) ->
				$(textarea).height textarea.scrollHeight # set the proper heights for textarea's

		# - updateModelAttributes is triggered by a change event on an vInputTable
		# - the input table returns a key as a string and a value as an object
		# - the value from the input table has to be turned into a string if the
		#   corresponding value in the model is a string
		# updateModelAttributes: (key, value) ->
		# 	obj = {}
			
		# 	if _.isString @model.get(key)
		# 		obj = value[0]
		# 	else
		# 		obj[key] = value
			
		# 	@model.set obj