# @trigger 'valuechanged'
# 		@param 'attr' @tablekey
#		@param 'data' @table2object()
#
define (require) ->
	# _ = require 'underscore'
	Backbone = require 'backbone'
	jqueryui = require 'jqueryui'
	BaseView = require 'views/base'
	# cInputTableRow = require 'collections/input/tablerow'
	# mInputTableRow = require 'models/input/tablerow'
	# vInputAutocomplete = require 'views/input/autocomplete'
	EditableList = require 'views/ui/editablelist'
	Typeahead = require 'views/input/typeahead'
	Textinput = require 'views/input/textinput'
	Textarea = require 'views/input/textarea'
	vInputSelect = require 'views/input/select'
	vWarning = require 'views/ui/warning'
	# tpl = require 'text!html/input/table.html'
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

				when 'typeahead'
					input = new Typeahead
						'value': @value
						'dbview': @input.dbview
						'span': @span
						'selectfromlist': true

				when 'editablelist'
					input = new EditableList
						'value': @value
						'dbview': @input.dbview
						'span': @span

			input.on 'valuechanged', (value) =>
				value = value.toJSON() if value.toJSON?
				@trigger 'valuechanged', @key, value

			@$el.html $('<label />').attr('for', @key).html(@title) if @title isnt ''
			@$el.append input.$el

			@