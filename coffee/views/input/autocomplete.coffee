# @option.model_type = name of the models (departements, users) to make the call to the api
# ??? @options.initValue if a value has already been entered (on edit)

define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	vAutoCompleteList = require 'views/autocomplete/list'
	vPopup = require 'views/main/popup'
	vInputList = require 'views/input/list'
	cResult = require 'collections/ac.result'
	hlpr = require 'helper'
	tpl = require 'text!templates/input/autocomplete.html'

	class vInputAutocomplete extends BaseView

		className: 'input-autocomplete'

		### EVENTS ###

		events:
			"keyup input.ac": "onKeyup"
			"blur input.ac": "closeResultListOnBlur"

			"mouseenter": "onHover"
			"mouseleave": "onHover"

			'mouseenter .ac-option': 'onHoverOption' 
			'mouseleave .ac-option': 'onHoverOption'

			'click .ac-option': 'onClickOption'

			"click div.remove": "removeResult"
			"click span.select-from-list": "selectFromList"

		onKeyup: (e) ->	
			value = e.target.value

			switch e.keyCode
				when 40 then @onPressArrow('down')
				when 38 then @onPressArrow('up')
				when 13 then @onPressEnter(value)
				when 27 then @closeResultList()
				else
					if value.length > 2
						if @fetchedJSON[value]?
							@resultlist.reset @fetchedJSON[value].models
						else
							hlpr.delayWithReset 300, =>
								@resultlist.url = '/api/ac/'+@view+'/'+value
								@resultlist.fetch
									success: (collection, response) =>
										@fetchedJSON[value] = hlpr.deepCopy collection
									error: (collection, response) =>
										@navigate 'login' if response.status is 401
					else
						@$('div.results').hide()

		closeResultListOnBlur: ->
			hlpr.delay 300, => @closeResultList() # The blur event needs a delay to

		onHover: (e) ->
			if 		@$('div.input').is(':visible') 	then div = @$('span.select-from-list')
			else if @$('div.result').is(':visible') then div = @$('div.remove')

			if 		e.type is 'mouseenter' and @$('div.results').is(':hidden')	then div.show()
			else if e.type is 'mouseleave' 										then div.hide()

		onHoverOption: (e) ->
			@resultlist.highlightByID(e.currentTarget.dataset.id)

		onClickOption: (e) ->
			@selectOption @resultlist.highlighted

		removeResult: ->
			@value = {}
			@render()
			@$('input').focus()

		selectFromList: ->
			@$('span.select-from-list').hide()

			il = new vInputList
				'view': @view

			il.on 'done', (model) => @selectOption model

			il.on 'rendering finished', =>
				popup = new vPopup
					parent: @
					child: il

		### /EVENTS ###

		initialize: ->
			@view = @options.view # The couchdb view to get the resultlist, ie 'group/departements', 'object/countries'
			@key = @options.key
			@row = @options.row 

			# The value of an autocomplete is an object with the attributes _id, key and value
			@value = if @row.get(@key)? then @row.get(@key) else {}

			@fetchedJSON = {}

			@resultlist = new cResult # Collection with the last result
				'view': @view
			@resultlist.on 'reset', @renderResultList, @
			@resultlist.on 'model highlighted', (id) =>
				@$('.highlight').removeClass 'highlight'
				@$('div.ac-option[data-id='+id+']').addClass('highlight')

		render: ->	
			@$el.html _.template(tpl,
				'key': @key
				'value': @value)
			
			@$('div.results').css 'position', 'absolute'
			@$('div.results').css 'background-color', 'pink'

			@$('div.results').hide()

			if _.isEmpty(@value)
				@$('div.result').hide()
				@$('div.input').show()
			else
				@$('div.result').show()
				@$('div.input').hide()

			@

		renderResultList: ->
			@$('div.results').html ''
			delete @resultlist.highlighted
			
			@resultlist.each (model) =>
				@$('div.results').append $('<div />', 
					'data-id': model.get 'id'
					'class': 'ac-option'
					'id': 'ac-option-'+model.get('id')
					'text': model.get('value'))

			@$('div.results').css 'top', @$('input.ac').position().top
			@$('div.results').css 'left', @$('input.ac').position().left
			@$('div.results').css 'margin', 8 + @$('input.ac').height() + 'px 0 0 2px'

			@$('div.results').show()

		closeResultList: ->
			$('div.results').hide()

		onPressArrow: (direction) ->
			if @$('div.results').is(':hidden')
				@renderResultList()
			else
				if direction is 'down'
					@resultlist.highlightNext()
				else if direction is 'up'
					@resultlist.highlightPrev()

		onPressEnter: (value) ->
			value = hlpr.slugify value

			if @resultlist.highlighted? and @resultlist.highlighted.isNew() # Is a model from the result list selected (isNew() is false) or has the user entered the full name in the input (isNew() is true)?
				@resultlist.highlighted = @resultlist.find (model) ->
					model.get('slug') is value

			if @resultlist.highlighted?
				@selectOption @resultlist.highlighted

		selectOption: (model) ->
			@closeResultList()

			@$('div.result span').html model.get 'value'
			@$('div.result span').attr 'data-value', JSON.stringify(model)

			@$('div.result').show()

			@$('div.input').hide()

			@row.set @key, model.toJSON()