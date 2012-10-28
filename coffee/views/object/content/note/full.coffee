define (require) ->
	_ = require 'underscore'
	Markdown = require 'markdown'
	vFullContent = require 'views/object/content/full'
	tpl = require 'text!html/note/full.html'

	class vFullNote extends vFullContent

		render: ->
			# body = new Markdown.Converter().makeHtml(@model.get('body'))
			# @model.set 'body', body

			super

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@