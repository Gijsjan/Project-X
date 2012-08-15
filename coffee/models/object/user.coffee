define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'

	class mUser extends mObject

		urlRoot: '/api/user'
	
		defaults: _.extend({}, mObject.prototype.defaults,
			'type': 'user'
			'username': ''
			'name': ''
			'middle_name': ''
			'surname': ''
			'email': '')

		'validation':
			'email':
				'required': true
				'message': 'Please enter an e-mail address!'