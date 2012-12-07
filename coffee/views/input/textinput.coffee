define (require) ->
	BaseView = require 'views/base'

	class Textinput extends BaseView

		events:
			'change': 'onChange'

		onChange: (e) ->
			@trigger 'valuechanged', @$('input').val()

		initialize: ->
			[@key, @value, @span, @prepend, @append] = [@options.key, @options.value, @options.span, @options.prepend, @options.append]

			@render()

			super

		render: ->
			input = $('<input />')
			input.attr('type', 'text')
			input.attr('id', @key)
			input.attr('name', @key)
			input.attr('data-key', @key)
			input.addClass('span'+@span)
			input.val @value

			@$el.html input
			
			if @prepend?
				@$el.addClass('input-prepend')
				@$el.prepend $('<span />').addClass('add-on').html(@input.prepend)
			if @append?
				@$el.addClass('input-append')
				@$el.append $('<span />').addClass('add-on').html(@input.append)

			@