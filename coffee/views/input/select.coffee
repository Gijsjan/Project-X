# @option.model_type = name of the models (departements, users) to make the call to the api
# ??? @options.initValue if a value has already been entered (on edit)

define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	hlpr = require 'helper'
	tpl = require 'text!templates/input/select.html'

	class vInputSelect extends BaseView

		className: 'input-select'

		### EVENTS ###
		
		events:
			"keyup input.select": "onKeyup"
			"focus input.select": "showOptionList"
			"blur input.select": "hideOptionList"

			'mouseenter .ac-option': 'onMouseEnterOption'
			'click .ac-option': 'onClickOption'

		onKeyup: (e) ->
			value = e.currentTarget.value

			switch e.keyCode
				when 40 # Down
					next = @$('.highlight').next()
					option = if next.length > 0 then next else @$('div.ac-option:first-child')
					@highlight option
					@showOptionList()
				when 38 # Up
					prev = @$('.highlight').prev()
					option = if prev.length > 0 then prev else @$('div.ac-option:last-child')
					@highlight option
					@showOptionList()
				when 13 # Enter
					val = '' # Tmp var

					if 		@$('div.highlight').length is 1 				then val = @$('div.highlight').attr 'data-value' # If a div.ac-option is highlighted, than use the data-value attribute as value
					else if @$('div.ac-option span.highlight').length is 1 	then val = @$('div.ac-option span.highlight').parent().attr 'data-value' # If ONE div.ac-option is partly highlighted, than use the div's data-value attribute as value
					else if @optionlist.indexOf(value) > -1 				then val = value # If the value matched one of the options values, use this value
					
					if val isnt ''
						@selectOption val
				when 27
					@hideOptionList()
				else # Letters, numbers, shift, etc.
					@showOptionList()
					@$('.highlight').removeClass 'highlight'

					if value.length > 0
						# Find matched options
						matchedoptions = @$("div.ac-option[data-value*='"+value+"']")
						_(matchedoptions).each (mo) =>
							highlighted_html = $(mo).attr('data-value').replace(value, '<span class="highlight">'+value+'</span>')
							$(mo).html highlighted_html
					else
						@hideOptionList()

		showOptionList: ->
			@$('div.results').css 'top', @$('input.select').position().top
			@$('div.results').css 'left', @$('input.select').position().left
			@$('div.results').css 'margin', 8 + @$('input.select').height() + 'px 0 0 2px'

			@$('div.results').show()

		hideOptionList: (e) ->
			hlpr.delay 200, => @$('div.results').hide() # The blur event needs a delay to give the click event a chance 

		onMouseEnterOption: (e) ->
			@highlight $(e.currentTarget)

		onClickOption: (e) ->
			@selectOption $(e.currentTarget).attr 'data-value'
		
		### /EVENTS ###

		initialize: ->
			@optionlist = @options.options #ie departements, users; var named optionlist cuz options overrides @options
			@key = @options.key #ie capacity, frequency
			@row = @options.row 

			# The value of a select is a string containing one of the options
			@value = if @row.get(@key)? then @row.get(@key) else ''

			super

		render: ->	
			@$el.html _.template tpl,
				'optionlist': @optionlist
				'key': @key
				'value': @value
			
			@$('div.results').css 'position', 'absolute'
			@$('div.results').css 'background-color', 'pink'

			@$('div.results').hide()

			@

		highlight: (target) ->
			@$('.highlight').removeClass('highlight')
			target.addClass 'highlight'

		selectOption: (value) ->
			@$('input.select').val value
			@$('input.select').addClass 'complete'
			@hideOptionList()

			@trigger 'option selected'