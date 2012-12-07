define (require) ->
	BaseRouter = require 'routers/base'
	# mObject = require 'models/object/object'
	# vLogin = require 'views/main/login'
	# vContentList = require 'views/object/content/list'
	# vListControl = require 'views/object/content/list.control'

	class MainRouter extends BaseRouter

		'routes':
			'': 'home'
			'404': 'notfound'

			# 'test/2012filter': 'filter2012'
			# 'all': 'home'
			# 'content': 'home'
			# 'object/:id': 'object'
			# 'tag/:slug': 'tagList'
			# 'login': 'login'
			# 'logout': 'logout'

		home: ->
			@breadcrumbs = {}

			$('div#main').html ''

		notfound: ->
			@breadcrumbs = 'Not found': ''

			$('div#main').html 'not found!' # CHANGE TO VIEW

		# if an object is not found cuz a) the type is unknown or b) the id is not found, it is redirected to /object/:id
		# if object cannot find the type and id (ie: the id is wrong), it is redirected to 404
		# object: (id) ->
		# 	model = new mObject 'id': id
		# 	model.fetch
		# 		success: (model, response) =>
		# 			@navigate response.text+'/'+id,
		# 				'trigger': true
		# 		error: (model, response) => @globalEvents.trigger response.status+''


		# contentList: (slug) ->
		# 	home = new vListControl
		# 		preSelectedContent: [slug]
		# 	$('div#main').html home.$el

		# tagList: (slug) ->
		# 	home = new vListControl
		# 		preSelectedTag: [slug]
		# 	$('div#main').html home.$el


		# login: ->
		# 	# console.log @lastRoute
		# 	loginView = new vLogin
		# 		href: @lastRoute # send lastRoute to the loginView to redirect the user to where s/he came from, lastRoute is stored in app.js
		# 	$('div#main').html loginView.render().$el

		# logout: ->
		# 	# $.post('/api/logout').error (response) =>
		# 	# 	@navigate 'login', true if response.status is 401
		# 	$.ajax
		# 		type: 'DELETE'
		# 		url: '/db/_session'
		# 		success: =>
		# 			@globalEvents.trigger 'logoutsuccess'
		# 			@navigate 'login',
		# 				'trigger': true
