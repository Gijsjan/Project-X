define (require) ->
	mNote = require 'models/content/note.full'
	ContentView = require 'views/content/full'
	tpl = require 'text!html/content/note/full.html'

	class Note extends ContentView

		render: ->
			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@