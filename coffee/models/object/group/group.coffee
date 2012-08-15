define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'
	cUser = require 'collections/object/user'

	mObject.extend

		'urlRoot': '/api/group'

		'defaults': _.extend({}, mObject.prototype.defaults,
			'slug': ''
			'title': ''
			'users': new cUser())

		###
		set: (attributes, options) ->
			#console.log 'model group set'
			#console.log _(attributes).clone()
			
			if not attributes.users? or not (attributes.users instanceof cUser)
				attributes.users = new cUser attributes.users
			
			mObject.prototype.set.call @, attributes, options
		###

		parse: (response) ->
			response.users = new cUser response.users
			response

		'validation':
			'title':
				'required': true
				'message': 'Please enter a title!'