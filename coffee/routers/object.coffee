define [
		'switchers/views.edit'
		'switchers/views.full'
		'switchers/collections'
		'switchers/models'
		'views/content/list'
		'helper'
	], (EditViews, FullViews, Collections, Models, vContentList, helper) ->
		Backbone.Router.extend
			routes:
				":object_type/add": "edit"
				":object_type/edit/:id": "edit"
				":object_type/:id": "show"
				":object_types": "collection"
			add: (object_type) ->
				parent_type = helper.getParentType object_type

				data = 
					object_type: object_type
					className: parent_type+' '+object_type
					model: new Models[object_type]()

				add = new EditViews[object_type] data

				$('div#main').html add.render().$el
			show: (object_type, id) ->
				parent_type = helper.getParentType object_type

				data =
					object_type: object_type
					object_id: id
					className: parent_type+' full '+object_type
					id: 'object-'+id
					model: new Models[object_type] 
						id: id

				full = new FullViews[object_type] data

				$('div#main').html full.$el
			edit: (object_type, id) ->
				parent_type = helper.getParentType object_type

				data = {
					object_type: object_type
					className: parent_type+' edit '+object_type
					model: new Models[object_type]()
				};

				if id?
					data.id = 'object-'+id
					data.object_id = id
					data.model = new Models[object_type] id: id
				else
					data.model = new Models[object_type]()

				ev = new EditViews[object_type] data
				
				$('div#main').html ev.render().$el
			collection: (object_types) ->
				v = new vContentList 'collection': new Collections[object_types]()
				$('div#main').html v.$el