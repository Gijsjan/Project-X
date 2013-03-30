define (require) ->
	BaseView = require 'views/base'
	moment = require 'moment'

	class DateInput extends BaseView

		'tagName': 'input'

		initialize: ->
			@render()

		render: ->
			@$el.attr 'type', 'date'
			@$el.attr 'value', moment().format('YYYY-MM-DD')

			@