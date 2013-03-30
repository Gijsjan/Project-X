define (require) ->
	BaseView = require 'views/base'
	hlpr = require 'helper'
	tpl = require 'text!html/ui/warning.html'

	class vWarning extends BaseView

		className: 'alert'

		events:
			'click .ok': 'clickOk'
			'click .cancel': 'clickCancel'

		clickOk: ->
			@trigger 'ok'
			@$el.alert('close')

		clickCancel: ->
			@$el.alert('close')

		initialize: ->
			@render()

		render: ->
			renderedHTML = _.template tpl

			@$el.html renderedHTML
			
			$('body').prepend @$el

			@$el.width @screenwidth/3

			top = @screenheight/2 - @$el.height()
			left = @screenwidth/2 - @$el.width()/2
			@$el.css('top', top)
			@$el.css('left', left)

			@$el.addClass('alert-block alert fade in')
