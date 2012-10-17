# inputvalue = string = the value from the input
# @value = object = (selected) option in the format returned by db for autocomplete options {_id: '', key: '', value: ''}

define (require) ->
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	BaseView = require 'views/base'
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
			obj = @alloptions.find (model) =>
				value = @$('input').val()
				index = value.lastIndexOf(' (')
				return model.get('value') is value.substring(0, index)

			hlpr.delay 300, => # delay is waiting for find() to finish
				if obj?
					@trigger 'valuechanged', obj.toJSON()
				else
					@trigger 'valuechanged', @emptyValue()
					@$el.addClass 'warning'
		
		onBlur: ->
			# console.log 'vInputTypeahead.onBlur'
			@trigger 'valuechanged', @emptyValue() if @$('input').val() is ''
			# @row.set @key, @emptyValue() if @$('input').val() is ''

		onClickButton: ->
			# console.log 'vInputTypeahead.onClickButton()'
			modal = new vModal
				'items': @alloptions
			
			# $('body').append modal.render().$el

			modal.on 'itemselected', (model) => # when user clicks or gives enter on active option the itemselected event is triggered
				@$('input').val model.get('value')
				@$el.removeClass 'warning'
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
					_.map @alloptions.filter((model) -> model.get('key').indexOf(query) isnt -1), (m) -> 
						value = m.get('value')
						value = value + ' ('+m.get('count')+')' if m.get('count')?

			@

		emptyValue: ->
			id: ''
			key: ''
			value: ''