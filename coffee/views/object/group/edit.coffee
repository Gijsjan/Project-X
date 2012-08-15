define (require) ->
	_ = require 'underscore'
	EditTemplates = require 'switchers/templates.edit'
	vAutoComplete = require 'views/autocomplete/autocomplete'
	vEditObject = require 'views/object/edit'
	vEditUser = require 'views/object/user/edit'
	vPopup = require 'views/main/popup'
	mUser = require 'models/object/user'
	hlpr = require 'helper'
	tpl = require 'text!templates/group/edit.html'

	class vEditGroup extends vEditObject
	
		ac_inputs: {}

		events: _.extend({}, vEditObject.prototype.events, 
			"keyup input.ac": "onACKeyup"
			'keyup #title': 'slugify'
			'click .add-user': 'addUser')

		addUser: ->
			eu = new vEditUser
				model: new mUser
			
			eu.on 'done', (model) =>
				model.set 'title', model.get('email')
				@model.get('users').add model

			popup = new vPopup
				parent: @
				child: eu

		# Overrides vEditObject.render()
		render: ->
			html = _.template tpl, @model.toJSON() # renders page title and editable title and slug inputs
			@$el.html html

			childtpl = EditTemplates[@model.get 'type'] # get the comment template from the switcher
			html = _.template childtpl, @model.toJSON()
			@$('.group-child').html html

			@addAutoComplete $(input) for input in @$('input.ac') # Make every input with class 'ac'

			@

		addAutoComplete: (input) ->
			input_id = input.attr('id') # The ID of the input tag ie: 'departements'

			list = @model.get input_id # Get the collection in the model ie: @model.get 'departements'

			@ac_inputs[input_id] = {} # Make an object for the input
			@ac_inputs[input_id].ac = new vAutoComplete # add the AutoComplete View to the object
				'input_id': input_id # send the input_id for $.getJSON
				'collection': list
				'position': input.position() # send the position of the input to position the dropdownlist

			# every autocomplete input has its own renderList function which calls the automcomplete renderList function
			@ac_inputs[input_id].renderList = =>
				@$('#selected-'+input_id).html @ac_inputs[input_id].ac.renderList() # @ac.renderList() returns HTML
				@$('#'+input_id).val ''

			list.on 'add', @ac_inputs[input_id].renderList, @
			list.on 'remove', @ac_inputs[input_id].renderList, @

			@ac_inputs[input_id].renderList()

		onACKeyup: (e) ->
			input_id = $(e.currentTarget).attr('id')
			@ac_inputs[input_id].ac.onKeyup e.keyCode, e.target.value

		slugify: ->
			value = hlpr.slugify @$('#title').val()
			
			@model.set 'slug', value, 'silent': true
			@$('#slug').val(value)