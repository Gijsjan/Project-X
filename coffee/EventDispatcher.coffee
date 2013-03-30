define (require) ->
	Backbone = require 'backbone'
	vLogin = require 'views/ui/login'

	class EventDispatcher

		constructor: ->
			_.extend @, Backbone.Events
			router = new Backbone.Router

			@on '401', -> # Unauthorized
				loginView = new vLogin()
				$('div#main').html loginView.render().$el

			@on 'modelSaved', (model) ->
				id = model.get('id')
				type = model.type
				id = model.get('username') if model.type is 'person'

				url = type+'/'+id
				url = 'content/'+url if model.isContent()
				
				router.navigate url, 'trigger': true

			@on 'modelRemoved', (model) ->
				# DOESNT GO TO CORRECT PAGE
				console.log 'EventDispatcher.modelRemoved: but navigates to model.type instead of plural or removed page'
				
				url = model.type
				url = 'content/'+url if model.isContent()
				router.navigate url, 'trigger': true

	new EventDispatcher()