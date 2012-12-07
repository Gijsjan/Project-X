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

	# ev.on 'unauthorized', -> # The 'login' events triggers the route to /login
	# 	loginView = new vLogin 'currentUser': currentUser
	# 	$('div#main').html loginView.render().$el

	# ev.on 'loginSuccess', -> # If the login is a success, the user info is still not loaded, so re-check the login
	#     new mPerson().checkLogin()

			@on 'modelSaved', (model) ->			
				router.navigate model.get('type')+'/'+model.get('id'), 'trigger': true

			@on 'modelRemoved', (model) ->
				router.navigate model.get('type'), 'trigger': true

	new EventDispatcher()