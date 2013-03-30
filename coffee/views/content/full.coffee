define (require) ->
	Full = require 'views/full'
	tpl = require 'text!html/content/full.html'

	class Content extends Full

		render: ->
			tplRendered = _.template tpl, @model.toJSON()
			@$el.html tplRendered