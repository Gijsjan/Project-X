define (require) ->
	# _ = require 'underscore'
	vListed = require 'views/listed'
	tpl = require 'text!html/link/listed.html'

	class vLink extends vListed
		render: ->
			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.listed-body').html tplRendered

			@