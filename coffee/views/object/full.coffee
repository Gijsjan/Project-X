define (require) ->
	BaseView = require 'views/base'
	
	class vFullObject extends BaseView

		events:
			"click .editevent" : "edit"
			"click .addevent" : "add"
			"click .delevent" : "del"

		edit: (e) ->
			@navigate @options.object_type + '/edit/' + @options.object_id

		add: (e) ->
			@navigate @options.object_type + '/add'

		del: (e) ->
			if confirm 'Are you sure? :)'
				@model.destroy
					success: (model, response) =>
						@navigate 'content/' + @options.object_type
					error: (model, response) =>
						console.log 'error'
						console.log response

		initialize: ->
			console.log 'vFullObject.initialize()'
			@model.fetch
				success: (model, response) =>
					# console.log 'vFullObject.initialize() @model.fetch success'
					@modelManager.register model
					@render()
				error: (model, response) =>
					if response.status is 401
						# console.log 'vFullObject.initialize() @model.fetch 401'
						@navigate 'login'
					else if response.status is 404
						# console.log 'vFullObject.initialize() @model.fetch 404'
						route = JSON.parse(response.responseText).route
						@navigate route
					else
						# console.log 'vFullObject.initialize() @model.fetch error'
						console.log response #debugging
