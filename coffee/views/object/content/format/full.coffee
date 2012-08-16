define (require) ->
	_ = require 'underscore'
	vFullContent = require 'views/object/content/full'
	tpl = require 'text!html/format/full.html'

	vFullContent.extend
		render: ->
			vFullContent.prototype.render.apply @

			rtpl = _.template tpl, @model.toJSON()
			@$('.content-body').html rtpl

			@