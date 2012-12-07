define (require) ->
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	BaseView = require 'views/base'
	vModal = require 'views/ui/modal'
	vInputList = require 'views/input/list'
	cListItems = require 'collections/listitems'
	hlpr = require 'helper'
	tpl = require 'text!html/input/typeahead.html'

	# Typeahead shows an option list while typing an input
	# The list is filled with objects from a db call (@dbview) or an existing list (@items)
	# An object is passed to vInputTable when selected

	class Typeahead extends BaseView

		className: 'input-typeahead'

		events:
			'change': 'onChange'
			'blur': 'onBlur'
			'click button': 'onClickButton'

		onChange: (e) ->
			# console.log 'vInputTypeahead.onChange'
			@$el.removeClass 'warning'
			model = @alloptions.find (model) =>
				value = @$('input').val()
				# index = value.lastIndexOf(' (')
				# value = if index > -1 then value.substring(0, index) else value
				return model.get('title') is value

			# WHAT IF ALLOPTIONS LIST IS VERY LONG AND TAKING LONGER THAN 300 MS??? AND WHY IS IT NOT PROCEDURAL?
			hlpr.delay 300, => # delay is waiting for find() to finish
				if model?
					# @trigger 'valuechanged', model.toJSON()
					@valuechanged(model)
				else
					@$el.addClass 'warning'
					@valuechanged()
		
		onBlur: ->
			# console.log 'vInputTypeahead.onBlur'
			@valuechanged() if @$('input').val() is ''

		onClickButton: ->
			# console.log 'vInputTypeahead.onClickButton()'
			inputList = new vInputList
				'items': @alloptions

			modal = new vModal
				'view': inputList

			inputList.on 'itemselected', (item) => # when user clicks or gives enter on active option the itemselected event is triggered
				modal.hide()
				@$el.removeClass 'warning'
				@$('input').val item.get('title')
				@valuechanged(item)

			false

		valuechanged: (item = {}) ->
			@clear()
			@trigger 'valuechanged', item.toJSON()

		initialize: ->		
			# @value = if @options.value? and @options.value isnt '' then @options.value else '' # the initial value the <input> should hold
			@span = if @options.span? then @options.span else 2 # the width of the input
			@selectfromlist = if @options.selectfromlist? then @options.selectfromlist else false # if the user can select the item from a list (modal)
			@dbview = if @options.dbview? then @options.dbview else '' # DBview is the name of the view in CouchDB ie: 'object/countries'
			@items = if @options.items? then @options.items else ''

			if @items is '' and @dbview isnt ''
				@alloptions = new cListItems [], 'dbview': @dbview
				@alloptions.fetch
					success: (collection, response) => @render()
					error: (collection, response) => @globalEvents.trigger response.status+''
			else
				@alloptions = new cListItems @items.models
				@render()

		render: ->
			# model = @alloptions.get(@value)
			# value = if model? then model.get('title') else ""

			renderedHTML = _.template tpl,
				# 'value': value
				'span': @span
			@$el.html renderedHTML

			@$el.addClass 'control-group'
			if @selectfromlist
				@$('input').width @$('input').width() - 29 # the added icon is 29px wide, so subtract from input width to keep same width as other inputs
				@$el.addClass 'input-append'
				b = $('<button />').addClass('btn btn-narrow').html $('<i />').addClass('icon-list')
				@$el.append b

			@$('input').typeahead
				'source': (query, process) => 
					@alloptions
						.chain()
						.filter((item) -> (new RegExp(query, 'i')).test(item.get('title')))
						.map((item) -> item.get('title'))
						.value()

			@

		clear: ->
			@$('input').val ''