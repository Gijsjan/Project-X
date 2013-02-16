define (require) ->
	Backbone = require 'backbone'
	vLogin = require 'views/main/login'

	class EventDispatcher

		constructor: ->
			_.extend @, Backbone.Events
			router = new Backbone.Router

			@on '401', -> # Unauthorized
				loginView = new vLogin()
				$('div#main').html loginView.render().$el

			@on 'modelSaved', (model) ->
				id = model.get('id')
				id = model.get('username') if model.type is 'person'

				router.navigate model.type+'/'+id, 'trigger': true

			@on 'modelRemoved', (model) ->
				# DOESNT GO TO CORRECT PAGE
				console.log 'EventDispatcher.modelRemoved: but navigates to model.type instead of plural or removed page'
				router.navigate model.type, 'trigger': true

	new EventDispatcher()