define (require) ->
	# $ = require 'jquery'
	# _ = require 'underscore'
	# Backbone = require 'backbone'
	vEditObject = require 'views/object/edit'
	# vEditTags = require 'views/tag/edit'

	class vEditContent extends vEditObject

		render: ->
			super

			# et = new vEditTags model: @model
			# @$('.tags-wrapper').append et.render().$el

			@