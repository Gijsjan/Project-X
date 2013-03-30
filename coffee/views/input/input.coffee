define (require) ->
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	EditableList = require 'views/input/editablelist'
	AccessList = require 'views/input/accesslist'
	Typeahead = require 'views/input/typeahead'
	Select = require 'views/input/select'
	Textinput = require 'views/input/textinput'
	Textarea = require 'views/input/textarea'
	vInputSelect = require 'views/input/select'
	vWarning = require 'views/ui/warning'
	hlpr = require 'helper'

	class Input extends BaseView

		className: 'input'

		### /EVENTS ###

		initialize: ->
			[@key, @value, @title, @span, @input] = [@options.key, @options.value, @options.title, @options.span, @options.input]

			@render()

			super

		render: ->
			switch @input.type

				when 'textinput'
					input = new Textinput
						'key': @key
						'value': @value
						'span': @span
						'prepend': @input.prepend
						'append': @input.append

				when 'textarea'
					input = new Textarea
						'key': @key
						'value': @value
						'span': @span

				when 'select'
					input = new Select
						'value': @value
						'url': @input.url
						'span': @span


				when 'editablelist'
					input = new EditableList
						'value': @value
						'config': @input
						'span': @span

				when 'accesslist'
					input = new AccessList
						'value': @value
						'config': @input
						'span': @span

			input.on 'valuechanged', (value) =>
				value = value.toJSON() if value.toJSON?
				@trigger 'valuechanged', @key, value

			@$el.html $('<label />').attr('for', @key).html(@title) if @title isnt ''
			@$el.append input.$el

			@