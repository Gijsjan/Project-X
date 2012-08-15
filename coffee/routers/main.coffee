define (require) ->
	mObject = require 'models/object/object'
	vLogin = require 'views/main/login'
	vContentList = require 'views/object/content/list'
	vListControl = require 'views/object/content/list.control'

	Backbone.Router.extend
		routes:
			"": "home"
			'all': 'home'
			'content': 'home'
			'object/:id': 'object' 
			'content/:slug': 'contentList'
			'tag/:slug': 'tagList'
			'404': 'notfound'
			'login': 'login'
			'logout': 'logout'

		home: ->
			home = new vListControl()
			$('div#main').html home.$el

		# if an object is not found cuz a) the type is unknown or b) the id is not found, it is redirected to /object/:id
		# if object cannot find the type and id (ie: the id is wrong), it is redirected to 404
		object: (id) ->
			model = new mObject 'id': id
			model.fetch
				success: (model, response) =>
					@navigate response.text+'/'+id,
						'trigger': true
				error: (model, response) =>
					if response.status is 401
						@navigate 'login',
							'trigger': true
					if response.status is 404
						@navigate '404',
							'trigger': true


		contentList: (slug) ->
			home = new vListControl
				preSelectedContent: [slug]
			$('div#main').html home.$el

		tagList: (slug) ->
			home = new vListControl
				preSelectedTag: [slug]
			$('div#main').html home.$el

		notfound: ->
			$('div#main').html 'not found!'

		login: ->
			#console.log @lastRoute
			loginView = new vLogin
				href: @lastRoute # send lastRoute to the loginView to redirect the user to where s/he came from, lastRoute is stored in app.js
			$('div#main').html loginView.render().$el

		logout: ->
			$.post('/api/logout').error (response) =>
				@navigate 'login', true if response.status is 401