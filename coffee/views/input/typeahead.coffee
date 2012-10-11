# inputvalue = string = the value from the input
# @value = object = (selected) option in the format returned by db for autocomplete options {_id: '', key: '', value: ''}

define (require) ->
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	BaseView = require 'views/base'
	vAutoCompleteList = require 'views/autocomplete/list'
	vPopup = require 'views/main/popup'
	vModal = require 'views/main/modal'
	# vInputList = require 'views/input/list'
	cResult = require 'collections/ac.result'
	hlpr = require 'helper'
	tpl = require 'text!html/input/typeahead.html'

	class vInputTypeahead extends BaseView

		className: 'input-append'

		events:
			'change': 'onChange'
			'blur': 'onBlur'
			'click button': 'onClickButton'

		onChange: ->
			# console.log 'vInputTypeahead.onChange'
			obj = @alloptions.find (model) => return model.get('value') is @$('input').val()

			hlpr.delay 300, => # delay is waiting for find() to finish
				if obj?
					@row.set @key, obj.toJSON()
					@$el.removeClass 'warning'
				else
					@row.set @key, @emptyValue()
					@$el.addClass 'warning'
		
		onBlur: ->
			# console.log 'vInputTypeahead.onBlur'
			@row.set @key, @emptyValue() if @$('input').val() is ''

		onClickButton: ->
			# console.log 'vInputTypeahead.onClickButton()'
			modal = new vModal
				'items': @alloptions
			
			$('body').append modal.render().$el

			modal.on 'itemselected', (model) => # when user clicks or gives enter on active option the itemselected event is triggered
				$('.modal').modal('hide')
				@$('input').val model.get('value')
				@$el.removeClass 'warning'
				@row.set @key, model.toJSON()

			# PUT IN MODAL CLASS?
			$('.modal').on 'hidden', -> modal.remove()
			$('.modal').on 'shown', -> $(@).find('input').focus() # set focus on the input when modal is shown

			$('.modal').modal() # init modal

			false

		initialize: ->
			@row = @options.row
			@key = @options.column.key
			@span = @options.column.span
			@dbview = @options.column.input.dbview

			@alloptions = new cResult 'view': @dbview
			@alloptions.fetch
				'error': (collection, response) =>
					@navigate 'login' if response.status is 401

		render: ->
			value = @row.get(@key)
			value = @emptyValue() if not value? or value is ''

			renderedHTML = _.template tpl,
				'value': value
				'span': @span
			@$el.html renderedHTML

			@$el.addClass 'control-group' # add control-group to set warning class

			@$('input').typeahead
				'source': (query, process) =>
					_.map @alloptions.filter((model) -> model.get('key').indexOf(query) isnt -1), (m) ->  m.get('value')

			@

		emptyValue: ->
			id: ''
			key: ''
			value: ''