# @option.model_type = name of the models (departements, users) to make the call to the api
# ??? @options.initValue if a value has already been entered (on edit)

define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	cResult = require 'collections/ac.result'
	hlpr = require 'helper'
	tpl = require 'text!html/input/autocomplete.html'

	class vInputList extends BaseView

		className: 'input-list'

		### EVENTS ###

		events:
			"keyup input.ac": "onKeyup"

			'mouseenter .ac-option': 'onHoverOption' 
			'mouseleave .ac-option': 'onHoverOption'

			'click .ac-option': 'onClickOption'

		onKeyup: (e) ->
			# console.log 'vInputList.onKeyup()'
			value = hlpr.slugify(e.target.value)

			switch e.keyCode
				when 40 then @resultlist.highlightNext()
				when 38 then @resultlist.highlightPrev()
				when 13 then @onPressEnter(value)
				else
					@resultlist.reset @result.filter((model) -> model.get('key').indexOf(value) isnt -1)

		onHoverOption: (e) ->
			# console.log 'vInputList.onHoverOption()'
			@resultlist.highlightByID(e.currentTarget.dataset.id)

		onClickOption: (e) ->
			# console.log 'vInputList.onClickOption()'
			@selectOption @resultlist.highlighted

		### /EVENTS ###

		initialize: ->
			# console.log 'vInputList.initialize()'
			@dbview = @options.dbview # The couchdb view to get the resultlist, ie 'group/departements', 'object/countries'
			@key = @options.key


			@resultlist = new cResult # Collection with the last result
				'view': @dbview # REMOVE
			@resultlist.on 'reset', @renderOptions, @
			@resultlist.on 'model highlighted', (id) =>
				@$('.highlight').removeClass 'highlight'
				@$('div.ac-option[data-id='+id+']').addClass('highlight')

			@result = new cResult # Collection with the last result
				'view': @dbview
			@result.fetch
				success: (collection, response) =>
					@render()
				error: (collection, response) =>
					@navigate 'login' if response.status is 401

		render: ->
			# console.log 'vInputList.render()'
			@$el.html _.template(tpl,
				'cid': ''
				'key': @key
				'value':
					'value': '')

			@resultlist.reset @result.models

			@$('input.ac').focus()

			@

		renderOptions: ->
			# console.log 'vInputList.renderOptions()'
			@$('div.options').html ''
			delete @resultlist.highlighted
			
			@resultlist.each (model) =>
				@$('div.options').append $('<div />', 
					'data-id': model.get 'id'
					'class': 'ac-option'
					'id': 'ac-option-'+model.get('id')
					'text': model.get('value'))

		onPressEnter: (value) ->
			# console.log 'vInputList.onPressEnter()'
			value = hlpr.slugify value

			if not @resultlist.highlighted? # Is a model from the result list selected (isNew() is false) or has the user entered the full name in the input (isNew() is true)?
				@resultlist.highlighted = @resultlist.find (model) ->
					model.get('key') is value

			if @resultlist.highlighted?
				@selectOption @resultlist.highlighted

		selectOption: (model) ->
			@trigger 'done', model

# @option.model_type = name of the models (departements, users) to make the call to the api
# ??? @options.initValue if a value has already been entered (on edit)
###
define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	cResult = require 'collections/ac.result'
	tpl = require 'text!html/input/autocomplete.html'
	hlpr = require 'helper'

	class List extends BaseView

		className: 'input-list'

		events:
			'keyup input.ac': 'onKeyup'
			'mouseenter .ac-option': 'onHoverOption' 
			'mouseleave .ac-option': 'onHoverOption'
			'click .ac-option': 'onClickOption'

		onKeyup: (e) ->
			value = hlpr.slugify(e.target.value)
			@value = value

			if e.keyCode is 40 or e.keyCode is 38 # down or up arrow
				@result.highlightNext() if e.keyCode is 40
				@result.highlightPrev() if e.keyCode is 38
			else if e.keyCode is 13 # enter
				@trigger 'done', @result.highlighted
			else
				if value.length > 2
					hlpr.delayWithReset 300, =>
						@result.fetch
							success: (collection, response) =>
								@result.reset collection.filter((model) -> model.get('key').indexOf(value) isnt -1)
				else
					@render()

		onHoverOption: (e) ->
			@result.highlightByID(e.currentTarget.dataset.id)

		onClickOption: (e) ->
			@trigger 'done', @result.highlighted

		initialize: ->
			@value = ''

			@view = @options.view # ie: departements, users

			@result = new cResult
				'view': @view
			@result.on 'model highlighted', (id) =>
				@$('.highlight').removeClass 'highlight'
				@$('div.ac-option[data-id='+id+']').addClass('highlight')
			@result.on 'reset', @render, @

			@result.fetch
				success: (collection, response) =>
					@render()
				error: (collection, response) =>
					@navigate 'login' if response.status is 401

			super


		render: ->
			# console.log 'vInputList.render()'

			@$el.html _.template tpl, 'collection': @result

			@$('input.ac').focus()

			@

		renderOptions: ->
			@$('div.options').html ''
			delete @resultlist.highlighted
			
			@resultlist.each (model) =>
				@$('div.options').append $('<div />', 
					'data-id': model.get 'id'
					'class': 'ac-option'
					'id': 'ac-option-'+model.get('id')
					'text': model.get('value'))

			@$('div.options').css 'top', @$('input.ac').position().top
			@$('div.options').css 'left', @$('input.ac').position().left
			@$('div.options').css 'margin', 8 + @$('input.ac').height() + 'px 0 0 2px'
###