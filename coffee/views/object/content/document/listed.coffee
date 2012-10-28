define (require) ->
	_ = require 'underscore'
	vListed = require 'views/listed'
	tpl = require 'text!html/document/listed.html'

	class vListedDocument extends vListed
		render: ->
			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.listed-body').html tplRendered

			@