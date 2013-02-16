define (require) ->
	# _ = require 'underscore'
	PersonMin = require 'models/person.min'
	cGroup = require 'collections/group'
	# ev = require 'EventDispatcher'

	class PersonFull extends PersonMin

		'defaults':	_.extend({}, PersonMin::defaults, 
			'password': ''
			'groups': new cGroup())

		set: (attributes, options) ->
			if _.isObject attributes and attributes.groups?
				console.log 'PersonFull.set: attributes is an object and has "groups", but nothing is implemented for that! FIX'
				console.log attributes.groups

			if attributes is 'groups'
				groups = @get 'groups'
				groups.reset options
			else
				super

		parse: (attributes) ->
			attributes.groups = new cGroup attributes.groups, 'parse': true

			super
				
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