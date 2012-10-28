define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	cComment = require 'collections/object/comment'
	tpl = require 'text!html/comment/list.user.html'

	Backbone.View.extend

		className: 'comment-list'

		initialize: ->
			@collection = new cComment()

			data = {}
			data.user = @options.user if @options.user?

			if @collection.length is 0
				@collection.fetch
					'data': data
					success: (collection, response) =>
						@render()
					error: (collection, response) => @globalEvents.trigger response.status+''

		render: ->
			@$el.html _.template tpl, 
				'comments': @collection
			@