define (require) ->
	BaseView = require 'views/base'

	class Textarea extends BaseView

		tagName: 'textarea'

		events:
			'keyup': 'onKeyup'
			'change': 'onChange'

		'height': 60

		onKeyup: (e) ->
			target = $(e.currentTarget)
			target.height(@height)
			target.height target[0].scrollHeight

		onChange: (e) ->
			@trigger 'valuechanged', @$el.val()

		initialize: ->
			[@key, @value, @span] = [@options.key, @options.value, @options.span]

			@render()

			super

		render: ->
			@$el.height(@height)
			
			@$el.attr('data-key', @key)
			@$el.attr('name', @key)
			@$el.attr('id', @key)
			@$el.addClass('span'+@span)
			@$el.html @value

			@