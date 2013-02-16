define (require) ->
	# _ = require 'underscore'
	# Markdown = require 'markdown'
	mNote = require 'models/content/note'
	ContentView = require 'views/content/full'
	tpl = require 'text!html/content/note/full.html'

	class Note extends ContentView

		render: ->
			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@