define (require) ->
	# _ = require 'underscore'
	vListed = require 'views/listed'
	tpl = require 'text!html/video/listed.html'

	class vListedVideo extends vListed
		render: ->
			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.listed-body').html tplRendered

			@