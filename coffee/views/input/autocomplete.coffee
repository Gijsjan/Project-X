# inputvalue = string = the value from the input
# @value = object = (selected) option in the format returned by db for autocomplete options {_id: '', key: '', value: ''}

define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	vAutoCompleteList = require 'views/autocomplete/list'
	vPopup = require 'views/main/popup'
	vInputList = require 'views/input/list'
	cResult = require 'collections/ac.result'
	hlpr = require 'helper'
	tpl = require 'text!html/input/autocomplete.html'

	class vInputAutocomplete extends BaseView

		className: 'input-autocomplete'

		### EVENTS ###

		events:
			"keyup input.ac": "onKeyup"
			"blur input.ac": "onBlurCloseOptionList"

			'mouseenter .ac-option': 'onHoverOption' 
			'mouseleave .ac-option': 'onHoverOption'

			'click .ac-option': 'onClickOption'

			"click span.list": "selectFromList"

		onKeyup: (e) ->
			# console.log 'vInputAutocomplete.onKeyup'
			inputvalue = hlpr.slugify(e.target.value)

			switch e.keyCode
				when 40 then @onPressArrow('down')
				when 38 then @onPressArrow('up')
				when 13 then @checkInputValue(inputvalue)
				when 27 then @closeOptionList()
				else
					if inputvalue.length > 2
						hlpr.delayWithReset 300, =>
							@alloptions.fetch
								success: (collection, response) =>
									@filteredoptions.reset collection.filter((model) -> model.get('key').indexOf(inputvalue) isnt -1)
								error: (collection, response) =>
									@navigate 'login' if response.status is 401
					else
						@$('ul.options').hide()

		onBlurCloseOptionList: (e) ->
			# console.log 'vInputAutocomplete.onBlurCloseOptionList'
			inputvalue = $(e.currentTarget).val()
			@checkInputValue inputvalue

			hlpr.delay 300, => @closeOptionList()

		onHoverOption: (e) ->
			@filteredoptions.highlightByID(e.currentTarget.dataset.id)

		onClickOption: (e) ->
			option = new Backbone.Model
				'id': e.currentTarget.dataset.id
				'key': e.currentTarget.dataset.slug
				'value': $(e.currentTarget).text()

			@selectOption option

		selectFromList: ->
			# console.log 'vInputAutocomplete.selectFromList()'
			
			il = new vInputList 'dbview': @dbview, 'key': @key
			il.on 'done', (option) => @selectOption option # option = {_id: '', key: '', value: ''}
			popup = new vPopup
				parent: @
				child: il

		### /EVENTS ###

		initialize: ->
			@dbview = @options.dbview # The couchdb view to get the Optionlist, ie 'group/departements', 'object/countries'
			@key = @options.key
			@row = @options.row 

			# The value of an autocomplete is an object with the attributes _id, key and value
			# The model returned from the list (selectFromList) is the same object
			@value = if @row? and @row.get(@key)? then @row.get(@key) else @emptyValue()

			@alloptions = new cResult # Collection with all possible options
				'view': @dbview
			@filteredoptions = new cResult # Filtered (by user) collection with wanted options 
			@filteredoptions.on 'reset', @renderOptionList, @
			@filteredoptions.on 'model highlighted', (id) =>
				@$('.highlight').removeClass 'highlight'
				@$('div.ac-option[data-id='+id+']').addClass('highlight')

		# Returns an empty value in the format the db returns its autocomplete values
		emptyValue: ->
			_id: ''
			key: ''
			value: ''

		render: ->	
			@$el.html _.template(tpl,
				'cid': @row.cid
				'key': @key
				'value': @value)

			@$('ul.options').hide()

			###
			if _.isEmpty(@value)
				@$('div.result').hide()
				@$('div.input').show()
			else
				@$('div.result').show()
				@$('div.input').hide()
			###

			@

		renderOptionList: ->
			@$('ul.options').html ''
			delete @filteredoptions.highlighted
			
			@filteredoptions.each (option) =>
				a = $('<a />').attr('tabindex', '-1').attr('href', '#').text option.get('value')
				@$('ul.options').append($('<li />').append(a))

			@$('ul.options').css 'top', @$('input.ac').position().top
			@$('ul.options').css 'left', @$('input.ac').position().left
			@$('ul.options').css 'margin', 8 + @$('input.ac').height() + 'px 0 0 2px'

			@$('ul.options').show()

		closeOptionList: ->
			@$('ul.options').hide()

		onPressArrow: (direction) ->
			if @$('ul.options').is(':hidden')
				@renderOptionList()
			else
				if direction is 'down'
					@filteredoptions.highlightNext()
				else if direction is 'up'
					@filteredoptions.highlightPrev()

		# Checks if the value in the input.ac represents a model in @filteredoptions
		# If a model is found, select this option
		checkInputValue: (inputvalue) ->
			return @selectOption @filteredoptions.highlighted if @filteredoptions.highlighted? # don't perform function if an option is highlighted
			return @setRow @emptyValue() if inputvalue is '' # don't perform function if inputvalue is empty

			inputvalue = hlpr.slugify inputvalue

			@filteredoptions.highlighted = @filteredoptions.find (model) ->
				model.get('key') is inputvalue

			if @filteredoptions.highlighted?
				@selectOption @filteredoptions.highlighted

		selectOption: (option) ->
			@closeOptionList()

			@$('input.ac').val(option.get('value'))

			@setRow option.toJSON()

		setRow: (value) ->
			@row.set @key, value