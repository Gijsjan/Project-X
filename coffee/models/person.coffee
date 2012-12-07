define (require) ->
	# _ = require 'underscore'
	BaseModel = require 'models/base'
	# ev = require 'EventDispatcher'

	class mPerson extends BaseModel

		'urlRoot': '/b/db/people'

		'defaults':
			'type': 'people'
			'title': ''
			'email': ''
				
			# $.ajax
			# 	type: 'POST'
			# 	dataType: 'json'
			# 	data:
			# 		'email': email
			# 		'password': $('#password').val()
			# 	error: (data) =>
			# 		data = $.parseJSON(data.responseText)
			# 		@$('#login-alert').html(data.reason).show()
			# 		@$('button.btn-primary').html 'Try again!'
			
		# 'urlRoot': ->
		# 	# console.log 'mUser.urlRoot()'
		# 	'/db/projectx/'+@get 'name'
	
		# defaults: _.extend({}, mObject::defaults,
		# 	'type': 'user'
		# 	'name': ''
		# 	'database': ''
		# 	'telephone': []
		# 	'e-mail': [])

		# checkLogin: ->
		# 	$.getJSON '/db/_session', (data) =>
		# 		if data.userCtx.name?
		# 			@set 'name', data.userCtx.name
		# 			@fetch
		# 				'success': (model, response) =>
		# 					ev.trigger 'userLoaded', model
		# 				'error': (model, response) =>
		# 					@navigate 'login' if response.status is 401
		# 		else
		# 			ev.trigger 'login'
				# @set 'name', data.userCtx.name

		# initialize: ->
			# @on 'change:name', =>
			# 	console.log 'mUser.on change:name'
			# 	console.log @get('name')
			# 	@fetch
			# 		'success': (model, response) =>
			# 			ev.trigger 'userLoaded', model
			# 		'error': (model, response) =>
			# 			@navigate 'login' if response.status is 401