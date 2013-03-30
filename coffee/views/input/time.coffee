define (require) ->
	BaseView = require 'views/base'
	moment = require 'moment'

	class TimeInput extends BaseView

		'tagName': 'input'

		initialize: ->
			@render()

		render: ->
			@$el.attr 'type', 'time'
			@$el.attr 'value', moment().format('HH:mm')

			@