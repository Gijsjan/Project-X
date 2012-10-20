# inputvalue = string = the value from the input
# @value = object = (selected) option in the format returned by db for autocomplete options {_id: '', key: '', value: ''}

define (require) ->
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	BaseView = require 'views/base'
	# mCountry = require 'models/object/object'
	vAutoCompleteList = require 'views/autocomplete/list'
	# vPopup = require 'views/main/popup'
	vModal = require 'views/main/modal'
	# vInputList = require 'views/input/list'
	cResult = require 'collections/ac.result'
	hlpr = require 'helper'
	tpl = require 'text!html/input/typeahead.html'

	class vInputTypeahead extends BaseView

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
				index = value.lastIndexOf(' (')
				value = if index > -1 then value.substring(0, index) else value
				console.log model.get('value')
				console.log value.toLowerCase()
				return model.get('value') is value

			hlpr.delay 300, => # delay is waiting for find() to finish
				if model?
					@trigger 'valuechanged', model.toJSON()
				else
					@$el.addClass 'warning'
					@trigger 'valuechanged', @emptyValue()
		
		onBlur: ->
			# console.log 'vInputTypeahead.onBlur'
			@trigger 'valuechanged', @emptyValue() if @$('input').val() is ''

		onClickButton: ->
			# console.log 'vInputTypeahead.onClickButton()'
			modal = new vModal
				'items': @alloptions

			modal.on 'itemselected', (model) => # when user clicks or gives enter on active option the itemselected event is triggered
				@$el.removeClass 'warning'
				@$('input').val model.get('key')
				@trigger 'valuechanged', model.toJSON()

			false

		initialize: ->		
			@value = if @options.value? and @options.value isnt '' then @options.value else @emptyValue() # the initial value the <input> should hold
			@span = if @options.span? then @options.span else 2 # the width of the input
			@selectfromlist = if @options.selectfromlist? then @options.selectfromlist else false # if the user can select the item from a list (modal)
			@dbview = if @options.dbview? then @options.dbview else '' # DBview is the name of the view in CouchDB ie: 'object/countries'
			@items = if @options.items? then @options.items else ''

			if @items is '' and @dbview isnt ''
				@alloptions = new cResult 'dbview': @dbview
				@alloptions.fetch
					'error': (collection, response) =>
						@navigate 'login' if response.status is 401
			else
				@alloptions = new cResult @items.models

		render: ->
			renderedHTML = _.template tpl,
				'value': @value
				'span': @span
			@$el.html renderedHTML

			@$el.addClass 'control-group'
			if @selectfromlist
				@$el.addClass 'input-append'
				b = $('<button />').addClass('btn btn-narrow').html $('<i />').addClass('icon-list')
				@$el.append b

			@$('input').typeahead
				'source': (query, process) =>
					filtered = @alloptions.filter (model) ->
						model.get('key').indexOf(query) isnt -1

					_.map filtered, (m) -> 
						value = m.get('key')
						value = value + ' ('+m.get('count')+')' if m.get('count')?
						value

			@

		emptyValue: ->
			id: ''
			key: ''
			value: ''