define (require) ->
	_ = require 'underscore'
	Markdown = require 'markdown'
	vFullContent = require 'views/object/content/full'
	tpl = require 'text!templates/note/full.html'

	vFullContent.extend
		render: ->
			body = new Markdown.Converter().makeHtml(@model.get('body'))
			@model.set 'body', body

			vFullContent.prototype.render.apply @

			tplRendered = _.template tpl, @model.toJSON()
			@$('.content-body').html tplRendered

			@