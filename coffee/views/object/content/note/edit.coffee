define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	Markdown = require 'markdown'
	vEditContent = require 'views/object/content/edit'
	tpl = require 'text!html/note/edit.html'

	class vEditNote extends vEditContent
	
		# events: _.extend({}, vEditContent::events,
		# 	'keyup #body': 'onKeyup')

		# onKeyup: (e) ->
		# 	if not @busy
		# 		@busy = true

		# 		setTimeout( =>
		# 			@renderPagedown $(e.currentTarget).val()
		# 		, 1600)

		# renderPagedown: (text) ->
		# 	@$('#pagedown').html @converter.makeHtml(text)
		# 	@$('#pagedown').scrollTop @$('#pagedown').height()
		# 	@busy = false

		# initialize: ->
		# 	@converter = new Markdown.Converter()
		# 	@busy = false

		# 	super
			
		render: ->
			super

			# @renderPagedown @model.get('body')

			@