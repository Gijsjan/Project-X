define (require) ->
	_ = require 'underscore'
	vFullContent = require 'views/object/content/full'
	tpl = require 'text!html/link/full.html'

	vFullContent.extend
		render: ->
			vFullContent.prototype.render.apply @

			tplr = _.template tpl, @model.toJSON()
			@$('.content-body').html tplr

			@