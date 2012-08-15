define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vPagination = require 'views/main/pagination'
	vSelector = require 'views/main/selector'
	vList = require 'views/object/list'
	#cContentList = require 'collections/content/content'

	Backbone.View.extend
		
		id: 'list-control'
		
		initialize: ->
			@$el.html $('<div />').attr('id', 'navigation')
			@$el.append $('<div />').attr('id', 'list')
			@$el.append $('<div />').attr('id', 'selectors')

			@pagination = new vPagination()
			@pagination.on 'changePage', @renderNewPage, @

			@contentselector = new vSelector
				'title': 'content'
			@contentselector.checkboxes = @options.preSelectedContent if @options.preSelectedContent
			@contentselector.on('checkboxChecked', @render, @)

			@list = new vList()

			data = {}
			data.user = @options.user if @options.user?

			if @collection.length is 0
				@collection.fetch
					'data': data
					success: (collection, response) =>
						@contentselector.collection = collection
						@list.collection = collection
						@render()
					error: (collection, response) =>
						@navigate 'login' if response.status is 401
		
		render: ->
			@pagination.reset();
			
			# empty the collections labelInfo of the selectors by resetting them
			@contentselector.labelInfo.reset()

			content_checked = if @contentselector.checkboxes.length is 0 then false else true
			#tag_checked = if @tagselector.checkboxes.length is 0 and @countryselector.checkboxes.length is 0 then false else true
			
			# go over each model in the total collection
			@collection.each (model) =>
				type = model.get 'type'
				show = false
				contentmatch = if @contentselector.checkboxes.indexOf(type) isnt -1 then true else false # is the content type of the current model checked? yes, then there is a 'content match'

				# if no checkbox is selected, every model is shown
				if not content_checked or contentmatch
					show = true

				if show
					@contentselector.updateLabelInfo type, true
					model.show = true
					@pagination.totalItems++
				else
					@contentselector.updateLabelInfo type, false
					model.show = false
				

			@collection.sort()

			@$('#selectors').html @contentselector.render().$el

			@$('#navigation').html @pagination.render().$el
			@$('#item-wrapper').html @list.render(@pagination.currentPage, @pagination.itemsPerPage).$el

			@pagination.delegateEvents()
			@contentselector.delegateEvents()
			
			@

		renderNewPage: ->
			@$('#item-wrapper').html @list.render(@pagination.currentPage, @pagination.itemsPerPage).$el
			@pagination.renderNavigation()