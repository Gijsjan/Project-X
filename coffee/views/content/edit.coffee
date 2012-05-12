define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditObject = require 'views/object/edit'
	vEditTags = require 'views/tag/edit'

	vEditObject.extend
		render: ->
			vEditObject.prototype.render.apply @

			et = new vEditTags model: @model
			@$('.tags-wrapper').append et.render().$el

			@