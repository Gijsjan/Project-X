define (require) ->
	mPerson = require 'models/person.full'
	ajax = require 'AjaxManager'
	ev = require 'EventDispatcher'

	class CurrentUser extends mPerson

		'authorized': false

		loadUser: (data) ->
			@set data
			@authorized = true
			@trigger 'loaded', @

		# Checks if a session exists on the server
		# If the session exists, the user is returned and the menu is loaded through an event
		# If no session exists a 401 is thrown and the login screen is shown
		authorize: ->
			ajax.get
				'url': '/db/authorize'
				success: (data) => @loadUser(data)
					

		login: (email, password) ->
			data =
				'email': email
				'password': password
			
			ajax.post data,
				'url': '/db/login'
				success: (data) => @loadUser(data)

		logout: ->
			ajax.post {},
				'url': '/db/logout'
				success: (data) =>
					@authorized = false
					# ev.trigger '401'
					window.location.href = '/'

	new CurrentUser()