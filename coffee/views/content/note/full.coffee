define (require) ->
	# _ = require 'underscore'
	# Markdown = require 'markdown'
	mNote = require 'models/content/note'
	vFullContent = require 'views/content/full'
	tpl = require 'text!html/content/note/full.html'

	class vFullNote extends vFullContent

		initialize: ->
			@model = new mNote 'id': @options.id

			super

		render: ->
			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@