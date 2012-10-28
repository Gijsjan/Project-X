define (require) ->
	BaseView = require 'views/base'
	
	class vFullObject extends BaseView

		events:
			"click .editevent" : "edit"
			"click .addevent" : "add"
			"click .delevent" : "del"

		edit: (e) ->
			@navigate @options.object_type + '/' + @options.object_id + '/edit'

		add: (e) ->
			@navigate @options.object_type + '/add'

		del: (e) ->
			if confirm 'Are you sure? :)'
				@model.destroy
					success: (model, response) =>
						# console.log model
						# console.log response
						# @navigate @model.get('bucket') + '/' + @model.get('id')
						@globalEvents.trigger 'modelRemoved', model
					error: (model, response) =>
						console.log 'error'
						console.log response

		initialize: ->
			# console.log 'vFullObject.initialize()'
			
			@model.fetch
				success: (model, response) =>
					# console.log 'vFullObject.initialize() @model.fetch success'
					@render()
				error: (collection, response) => @globalEvents.trigger response.status+''
