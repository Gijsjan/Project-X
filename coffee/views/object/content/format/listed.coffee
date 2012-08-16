define (require) ->
	_ = require 'underscore'
	vListedContent = require 'views/object/content/listed'
	tpl = require 'text!html/format/listed.html'

	vListedContent.extend
		render: ->
			vListedContent.prototype.render.apply @

			rtpl = _.template tpl, @model.toJSON()
			@$('.content-body').html rtpl

			@