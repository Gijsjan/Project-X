# inputvalue = string = the value from the input
# @value = object = (selected) option in the format returned by db for autocomplete options {_id: '', key: '', value: ''}

define (require) ->
	BaseView = require 'views/base'

	class vInputTextarea extends BaseView

		tagName: 'textarea'

		events:
			'keyup': 'onKeyup'
			'change': 'onChange'

		onKeyup: (e) ->
			target = $(e.currentTarget)
			target.height(20)
			target.height target[0].scrollHeight

		onChange: (e) ->
			# console.log 'vInputTextarea.onChange'
			@model.set @key, e.currentTarget.value

		initialize: ->
			@key = @options.key
			@model = @options.model

		render: ->
			@$el.attr('data-key', @key)
			@$el.height(20)

			value = if @model? and @model.get(@key)? then @model.get(@key) else ''
			
			@$el.attr('value', value)

			@