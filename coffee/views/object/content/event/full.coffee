define (require) ->
	_ = require 'underscore'
	vFullContent = require 'views/object/content/full'
	tpl = require 'text!html/event/full.html'

	vFullContent.extend
		render: ->
			vFullContent.prototype.render.apply @

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@