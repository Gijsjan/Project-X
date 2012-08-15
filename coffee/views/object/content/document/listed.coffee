define (require) ->
	_ = require 'underscore'
	vListedContent = require 'views/object/content/listed'
	tpl = require 'text!templates/document/listed.html'

	vListedContent.extend
		render: ->
			vListedContent.prototype.render.apply @

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@