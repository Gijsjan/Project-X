define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vListedContent = require 'views/content/listed'
	vPagination = require 'views/main/pagination'
	vSelector = require 'views/main/selector'
	cContentList = require 'collections/contentlist/contentlist'

	Backbone.View.extend
		id: 'contentlist'
		initialize: ->
			@collection ?= new cContentList()
			@collection.url = '/api/tag' + @options.tag if @options.tag?
			@colleciton.url = 'api/country' + @options.country if @options.country?

			if @collection.length is 0
				@collection.fetch
					success: (collection, response) =>
						@render()
						@selector = new vSelector
							collection: collection
							base_collection: _.clone collection
						@selector.render()
						@selector.collection.bind('reset', @render, @)
						return
					error: (collection, response) =>
						@navigate 'login' if response.status is 401
						return
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