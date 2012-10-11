# inputvalue = string = the value from the input
# @value = object = (selected) option in the format returned by db for autocomplete options {_id: '', key: '', value: ''}

define (require) ->
	bootstrap = require 'bootstrap'
	BaseView = require 'views/base'
	tpl = require 'text!html/input/select.html'
	hlpr = require 'helper'

	class vInputSelect extends BaseView

		className: 'dropdown'

		### EVENTS ###

		events:
			'change input': 'onInputChange'
			'focus input': 'onInputFocus'
			'blur input': 'onInputBlur'
			'keyup input': 'onInputKeyup'

			'blur button': 'onButtonBlur'
			'click button': 'onButtonClick'

			'click .dropdown-menu li a': 'onOptionClick'

		onInputChange: (e) ->
			# console.log 'vInputSelect.onInputChange'
			@setInputValue e.currentTarget.value

		onInputFocus: (e) ->
			# console.log 'vInputSelect.onInputFocus()'
			@open()

		onInputBlur: (e) ->
			# console.log 'vInputSelect.onInputBlur()'
			@close()

		onInputKeyup: (e) ->
			active = @$('ul.dropdown-menu li.active')
			@$('ul.dropdown-menu li.active').removeClass('active')
			
			switch e.keyCode
				when 40 # Down
					if active.length is 0
						@$('ul.dropdown-menu li:first').addClass('active')
					else 
						active.next().addClass('active')

					@open() if not @$el.hasClass 'open'
				when 38 # Up
					if active.length is 0
						@$('ul.dropdown-menu li:last').addClass('active')
					else 
						active.prev().addClass('active')

					@open() if not @$el.hasClass 'open'
				when 13 # Enter
					@setInputValue active.text()
				when 27 # Escape
					@close()

		onButtonBlur: (e) ->
			@close()

		onButtonClick: (e) ->
			@$el.toggleClass 'open'
			false

		onOptionClick: (e) ->
			# console.log 'vInputSelect.onOptionClick()'
			@setInputValue e.currentTarget.innerHTML
			false

		### /EVENTS ###

		initialize: ->
			@row = @options.row
			@key = @options.column.key
			@selectoptions = @options.column.input.options
			@span = @options.column.span

		render: ->
			value = if @row? and @row.get(@key)? then @row.get(@key) else ''
			renderedHTML = _.template tpl,
				'value': value
				'span': @span
				'selectoptions': @selectoptions
			@$el.html renderedHTML

			@

		validate: (value) ->
			console.log 'vInputSelect.validate()'
			index = hlpr.lcarray(@selectoptions).indexOf(value.toLowerCase())
			
			if index is -1
				@$('.control-group').addClass 'warning'
			else
				@$('.control-group').removeClass 'warning'
				value = @selectoptions[index]

			value

		setInputValue: (value) ->
			value = @validate value
			@$('input').val value
			@row.set @key, value
			@close()

		open: ->
			@$el.addClass 'open'

		close: ->
			hlpr.delay 100, => @$el.removeClass 'open'
