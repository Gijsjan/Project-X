define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vListedContent = require 'views/content/listed'
	vPagination = require 'views/main/pagination'
	cContentList = require 'collections/contentlist/contentlist'

	Backbone.View.extend
		id: 'contentlist'
		initialize: ->
			@collection ?= new cContentList()
			@collection.url = '/api/tag' + @options.tag if @options.tag?
			@colleciton.url = 'api/country' + @options.country if @options.country?

			@collection.fetch
				success: (collection, response) =>
					@render()
				error: (collection, response) =>
					@navigate 'login' if response.status is 401

		render: ->
			pgn = new vPagination totalItems: @collection.length

			@collection.each (model, index) ->
				t = new vListedContent
					id: 'object-'+model.get 'id'
					className: 'content listed '+model.get 'type'
					model: model

				pgn.addItem index, t.render().$el

			@$el.html pgn.render().$el

			@