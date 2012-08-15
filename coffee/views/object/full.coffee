define (require) ->
	Backbone.View.extend

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
			@model.fetch
				success: (model, response) =>
					@render()
				error: (model, response) =>
					if response.status is 401
						@navigate 'login'
					else if response.status is 404
						route = JSON.parse(response.responseText).route
						@navigate route
					else
						console.log response #debugging
