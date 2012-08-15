define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	cComment = require 'collections/object/comment'
	tpl = require 'text!templates/comment/list.user.html'

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
					error: (collection, response) =>
						@navigate 'login' if response.status is 401

		render: ->
			@$el.html _.template tpl, 
				'comments': @collection
			@