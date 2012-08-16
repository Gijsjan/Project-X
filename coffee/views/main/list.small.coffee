define (require) ->
	Backbone = require 'backbone'
	tpl = require 'text!html/main/list.small.html'
	
	Backbone.View.extend

		tagName: 'ul'

		className: 'small-list'

		render: ->
			rtpl = _.template tpl, 'items': @collection

			@$el.html rtpl
			
			@