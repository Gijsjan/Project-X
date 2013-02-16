define (require) ->
	BaseView = require 'views/base'
	ev = require 'EventDispatcher'
	tpl = require 'text!html/full.html'
	
	class Full extends BaseView

		events:
			"click .editevent" : "edit"
			"click .addevent" : "add"
			"click .delevent" : "remove"

		edit: (e) ->
			@navigate @model.type + '/' + @model.get('id') + '/edit'

		add: (e) ->
			@navigate @model.type + '/add'

		remove: (e) ->
			if confirm 'Are you sure? :)'
				@model.destroy
					success: (model, response) =>
						# console.log model
						# console.log response
						# @navigate @model.get('bucket') + '/' + @model.get('id')
						ev.trigger 'modelRemoved', model
					error: (model, response) =>
						console.log 'error'
						console.log response

		initialize: ->
			# console.log 'vFullObject.initialize()'
			
			@model.fetch
				success: (model, response) =>
					# console.log 'vFullObject.initialize() @model.fetch success'
					@render()
				error: (collection, response) => ev.trigger response.status+''

		render: ->
			data = @model.toJSON()
			data.type = @model.type
			data.id = @model.get('username') if data.type is 'person'

			tplRendered = _.template tpl, data
			@$el.html tplRendered

			@
