define (require) ->
	EditViews = require 'switchers/views.edit'
	FullViews = require 'switchers/views.full'
	Collections = require 'switchers/collections'
	Models = require 'switchers/models'
	vContentList = require 'views/object/content/list'
	vFormatList = require 'views/object/content/format/list'
	vObjectListControl = require 'views/object/list.control'
	hlpr = require 'helper'

	class ContentRouter extends Backbone.Router

		routes:
			"content/:object_type/new": "edit"
			"content/:object_type/edit/:id": "edit"
			"content/:object_type/:id": "show"
			"content/format": "formatlist" # DOESNT WORK WITH TRAILING SLASH?
			"content/:object_type": "list" # DOESNT WORK WITH TRAILING SLASH?

		show: (object_type, id) ->
			console.log 'ContentRouter.show()'
			# if Models[object_type]? # does this object_type have model? if true load the view, if not: navigate to /object/:id to find the correct view
			# parent_type = hlpr.getParentType object_type

			data =
				'object_type': object_type
				'object_id': id
				'className': 'content full '+object_type
				'id': 'object-'+id
				'model': new Models['content/'+object_type]
					'id': id

			full = new FullViews['content/'+object_type] data

			$('div#main').html full.$el
			# else
			# 	@navigate 'object/'+id,
			# 		'trigger': true

		edit: (object_type, id) ->
			# console.log 'ContentRouter -> edit()'
			# parent_type = hlpr.getParentType object_type # CHANGE THIS -> OBJECT/CONTENT/GROUP IS ALREADY GIVEN IN OBJECT_TYPE

			data =
				'className': 'content edit '+object_type # className cannot be dynamicly set in the view, only other options is using jQuery's addClass in the views initialize method
				'model': new Models['content/'+object_type]()

			if id? # id is defined when edit event is triggered, but not when the add event is triggered
				data.model = new Models['content/'+object_type] id: id #override the default model with a model with an id
				data.id = 'object-'+id

			ev = new EditViews['content/'+object_type] data
			ev.on 'done', (model) ->
				# console.log 'ContentRouter.edit() ' + object_type + ' || EditView || saved!'
				@navigate model.get('type') + '/' + model.get('id'), true

			@globalEvents.trigger 'showView',
				'render': false
				'currentView': ev

		formatlist: (object_type) ->
			# console.log 'ContentRouter -> formatlist()'
			v = new vFormatList()
			
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': v

		list: (object_type) ->
			# console.log 'ContentRouter -> list()'
			v = new vContentList 
				'collection': new Collections['content/'+object_type]()
			
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': v