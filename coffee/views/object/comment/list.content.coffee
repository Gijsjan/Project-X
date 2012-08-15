define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!templates/comment/list.content.html'

	Backbone.View.extend

		className: 'comment-list'

		initialize: ->
			@collection.on 'add', @render, @

		render: ->
			@$el.html _.template tpl, 
				'comments': @collection
			@