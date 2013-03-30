define (require) ->
	bootstrap = require 'bootstrap'
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	tpl = require 'text!html/input/select.html'
	hlpr = require 'helper'

	class Select extends BaseView

		className: 'dropdown'

		### EVENTS ###

		events:
			'change input': 'inputChange'
			'focus input': 'inputFocus'
			'blur input': 'inputBlur'
			'keyup input': 'inputKeyup'

			'blur button': 'buttonBlur'
			'click button': 'buttonClick'

			'click .dropdown-menu li a': 'optionClick'

		inputChange: (e) -> @setInputValue e.currentTarget.value

		inputFocus: (e) -> @open()

		inputBlur: (e) -> @close()

		inputKeyup: (e) ->
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
					option = @selectoptions.get active[0].dataset.id
					@setInputValue option
				when 27 # Escape
					@close()

		buttonBlur: (e) -> @close()

		buttonClick: (e) ->
			@$el.toggleClass 'open'
			false

		optionClick: (e) ->
			option = @selectoptions.get e.currentTarget.parentNode.dataset.id
			@setInputValue option
			false

		### /EVENTS ###

		initialize: ->
			[@option, @selectoptions, @url, @span] = [@options.value, @options.selectoptions, @options.url, @options.span]

			if @selectoptions.length > 0
				@selectoptions = new BaseCollection @selectoptions
				@render()				
			else
				@selectoptions = new BaseCollection {}, 'url': @url
				@selectoptions.fetch => @render()

			super

		render: ->
			renderedHTML = _.template tpl,
				'value': @option.value
				'span': @span
				'selectoptions': @selectoptions
			@$el.html renderedHTML

			@

		setInputValue: (option) ->
			@$('input').val option.get('value')
			@trigger 'valuechanged', option
			@close()

		open: ->
			@$el.addClass 'open'

		close: ->
			hlpr.delay 100, => @$el.removeClass 'open'
