define (require) ->
	_ = require 'underscore'
	vFullObject = require 'views/object/full'
	tpl = require 'text!templates/comment/full.html'

	vFullObject.extend
	
		render: ->
			vFullObject.prototype.render.apply @

			tplr = _.template tpl, @model.toJSON()
			@$el.html tplr

			@