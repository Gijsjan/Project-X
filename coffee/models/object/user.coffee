define (require) ->
	# _ = require 'underscore'
	BaseModel = require 'models/base'

	class mUser extends BaseModel

		'urlRoot': '/b/db/people'

		'defaults':
			'bucket': 'people'
			'title': ''
			'email': ''
			'password': ''
			
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
		# 					@globalEvents.trigger 'userLoaded', model
		# 				'error': (model, response) =>
		# 					@navigate 'login' if response.status is 401
		# 		else
		# 			@globalEvents.trigger 'login'
				# @set 'name', data.userCtx.name

		# initialize: ->
			# @on 'change:name', =>
			# 	console.log 'mUser.on change:name'
			# 	console.log @get('name')
			# 	@fetch
			# 		'success': (model, response) =>
			# 			@globalEvents.trigger 'userLoaded', model
			# 		'error': (model, response) =>
			# 			@navigate 'login' if response.status is 401