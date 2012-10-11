define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	vPagination = require 'views/main/pagination'
	vSelector = require 'views/main/selector'
	vList = require 'views/object/content/list'
	cContentList = require 'collections/object/content/content'

	class vListControl extends BaseView
		
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
		
			@tagselector = new vSelector
				'title': 'tag'
			@tagselector.checkboxes = @options.preSelectedTag if @options.preSelectedTag
			@tagselector.on('checkboxChecked', @render, @)

			@countryselector = new vSelector
				'title': 'country'
			@countryselector.checkboxes = @options.preSelectedTag if @options.preSelectedTag
			@countryselector.on('checkboxChecked', @render, @)

			@list = new vList()
			@globalEvents.on 'add-tag-to-selector', @addTagToSelector, @

			@collection ?= new cContentList()

			data = {}
			data.user = @options.user if @options.user?
			data.content_type = @options.content_type if @options.content_type?
			data.tag = @options.tag if @options.tag?
			data.country = @options.country if @options.country?

			if @collection.length is 0
				@collection.fetch
					'data': data
					success: (collection, response) =>
						@contentselector.collection = collection
						@tagselector.collection = collection
						@countryselector.collection = collection
						@list.collection = collection
						@render()
					error: (collection, response) =>
						@navigate 'login' if response.status is 401
		
		addTagToSelector: (slug) ->
			@tagselector.checkboxes.push slug
			@render()
		
		render: ->
			@pagination.reset();
			
			# empty the collections labelInfo of the selectors by resetting them
			@contentselector.labelInfo.reset()
			@tagselector.labelInfo.reset()
			@countryselector.labelInfo.reset()

			content_checked = if @contentselector.checkboxes.length is 0 then false else true
			tag_checked = if @tagselector.checkboxes.length is 0 and @countryselector.checkboxes.length is 0 then false else true
			
			# go over each model in the total collection
			@collection.each (model) =>
				type = model.get 'type'
				show = false
				contentmatch = if @contentselector.checkboxes.indexOf(type) isnt -1 then true else false # is the content type of the current model checked? yes, then there is a 'content match'

				# if no checkbox is selected, every model is shown
				if not content_checked and not tag_checked
					show = true
				# if no tag/country is checked all models with selected content are shown 
				else if not tag_checked
					show = true if contentmatch is true

				# getSelector is used in both tag loops to get the tag or country selector
				getSelector = (type) =>
					switch type
						when 'tag' then selector = @tagselector
						when 'country' then selector = @countryselector
						else selector = @tagselector

					selector

				# first tag loop checks if there is a 'tag match', ie the model has a tag that is checked
				# two loops are needed, cuz if the last of (say) three tags is a match, the first two must also be shown and thus 'active'	
				model.get('newtags').each (tag) =>
					slug = tag.get 'slug'
					selector = getSelector tag.get 'type'

					tagmatch = if selector.checkboxes.indexOf(slug) isnt -1 then true else false
					show = true if tagmatch is true

				# second tag loop updates the label info
				# variable show is used cuz if a model must be shown, all tags are 'active'
				model.get('newtags').each (tag) =>
					slug = tag.get 'slug'
					selector = getSelector tag.get 'type'

					if show
						selector.updateLabelInfo slug, true
					else
						selector.updateLabelInfo slug, false

				if show
					@contentselector.updateLabelInfo type, true
					model.set 'show', true
					@pagination.totalItems++
				else
					@contentselector.updateLabelInfo type, false
					model.set 'show', false
				

			@collection.sort()

			@$('#selectors').html @contentselector.render().$el
			@$('#selectors').append @countryselector.render().$el
			@$('#selectors').append @tagselector.render().$el

			@$('#navigation').html @pagination.render().$el
			@$('#item-wrapper').html @list.render(@pagination.currentPage, @pagination.itemsPerPage).$el

			@pagination.delegateEvents()
			@contentselector.delegateEvents()
			@tagselector.delegateEvents()
			@countryselector.delegateEvents()

			@

		renderNewPage: ->
			@$('#item-wrapper').html @list.render(@pagination.currentPage, @pagination.itemsPerPage).$el
			@pagination.renderNavigation()