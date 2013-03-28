define (require) ->
	PersonMin = require 'models/person.min'
	Groups = require 'collections/group'
	Content = require 'collections/content'
	# ev = require 'EventDispatcher'

	class PersonFull extends PersonMin

		'defaults':	_.extend({}, PersonMin::defaults, 
			'password': ''
			'groups': new Groups()
			'content': new Content())

		set: (attributes, options) ->
			if _.isObject attributes and (attributes.groups? or attributes.content?)
				console.log 'PersonFull.set: attributes is an object and has "groups", but nothing is implemented for that! FIX'
				console.log attributes.groups
				console.log attributes.content

			if attributes is 'groups'
				groups = @get 'groups'
				groups.reset options
			if attributes is 'content'
				content = @get 'content'
				content.reset options
			else
				super

		parse: (attributes) ->
			attributes.groups = new Groups attributes.groups, 'parse': true
			attributes.content = new Content attributes.content, 'parse': true

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