define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'

	class mComment extends mObject

		urlRoot: '/api/comment'

		defaults: _.extend({}, mObject.prototype.defaults,
			'type': 'comment'
			'comment': ''
			'content_id': 0)