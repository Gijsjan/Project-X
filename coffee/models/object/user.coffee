define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'

	class mUser extends mObject

		'urlRoot': ->
			# console.log 'mUser.urlRoot()'
			'/db/projectx/'+@get 'name'
	
		defaults: _.extend({}, mObject::defaults,
			'type': 'user'
			'name': ''
			'database': ''
			'telephone': []
			'e-mail': [])

		login: ->
			$.getJSON '/db/_session', (data) =>
				@set 'name', data.userCtx.name
				@fetch
					'success': (model, response) =>
						@modelManager.register model
						@globalEvents.trigger 'userLoaded', model
					'error': (model, response) =>
						@navigate 'login' if response.status is 401
				# @set 'name', data.userCtx.name

		initialize: ->
			# @on 'change:name', =>
			# 	console.log 'mUser.on change:name'
			# 	console.log @get('name')
			# 	@fetch
			# 		'success': (model, response) =>
			# 			@modelManager.register model
			# 			@globalEvents.trigger 'userLoaded', model
			# 		'error': (model, response) =>
			# 			@navigate 'login' if response.status is 401