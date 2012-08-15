define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	Markdown = require 'markdown'
	vEditContent = require 'views/object/content/edit'

	vEditContent.extend
	
		events: _.extend({}, vEditContent.prototype.events,
			'keyup #body': 'onKeyup')

		onKeyup: (e) ->
			if not @busy
				@busy = true

				setTimeout( =>
					@renderPagedown $(e.currentTarget).val()
				, 1600)

		renderPagedown: (text) ->
			@$('#pagedown').html @converter.makeHtml(text)
			@$('#pagedown').scrollTop @$('#pagedown').height()
			@busy = false

		initialize: ->
			@converter = new Markdown.Converter()
			@busy = false

			vEditContent.prototype.initialize.apply @
			
		render: ->
			vEditContent.prototype.render.apply @

			@renderPagedown @model.get('body')

			@