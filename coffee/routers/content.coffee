define (require) ->
	EditViews = require 'switchers/views.edit'
	FullViews = require 'switchers/views.full'
	Collections = require 'switchers/collections'
	Models = require 'switchers/models'
	vContentList = require 'views/object/content/list'
	vObjectListControl = require 'views/object/list.control'
	helper = require 'helper'

	class ContentRouter extends Backbone.Router

		routes:
			"content/:object_type/add": "edit"
			"content/:object_type/edit/:id": "edit"
			"content/:object_type/:id": "show"
			"content/:object_type": "list" # DOESNT WORK WITH TRAILING SLASH?

			"group/:object_type/add": "edit"
			"group/:object_type/edit/:id": "edit"
			"group/:object_type/:id": "show"
			"group/:object_types": "content_collection"
			#":object_types": "object_collection"

		show: (object_type, id) ->
			if Models[object_type]? # does this object_type have model? if true load the view, if not: navigate to /object/:id to find the correct view
				parent_type = helper.getParentType object_type

				data =
					'object_type': object_type
					'object_id': id
					'className': parent_type+' full '+object_type
					'id': 'object-'+id
					'model': new Models[object_type]
						'id': id

				full = new FullViews[object_type] data

				$('div#main').html full.$el
			else
				@navigate 'object/'+id,
					'trigger': true

		edit: (object_type, id) ->
			parent_type = helper.getParentType object_type # CHANGE THIS -> OBJECT/CONTENT/GROUP IS ALREADY GIVEN

			data =
				'className': parent_type+' edit '+object_type # className cannot be dynamicly set in the view, only other options is using jQuery's addClass in the views initialize method
				'model': new Models[object_type]()
				'hash': window.location.hash.substr(1)

			if id? # id is defined when edit event is triggered, but not when the add event is triggered
				data.model = new Models[object_type] id: id #override the default model with a model with an id
				data.id = 'object-'+id

			ev = new EditViews[object_type] data
			ev.on 'done', (model) ->
				# console.log 'ContentRouter.edit() ' + object_type + ' || EditView || saved!'
				@navigate model.get('type') + '/' + model.get('id'), true

			@globalEvents.trigger 'showView',
				'render': false
				'currentView': ev

		list: (object_types) ->
			console.log 'ContentRouter -> list()'
			v = new vContentList 
				'collection': new Collections[object_types]()
			
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': v