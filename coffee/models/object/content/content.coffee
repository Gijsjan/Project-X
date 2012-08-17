define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'
	cTag = require 'collections/object/tag'
	cComment = require 'collections/object/comment'

	class mContent extends mObject

		'urlRoot': '/db/projectx/'

		defaults: _.extend({}, mObject.prototype.defaults,
			'show': true
			'newtags': []
			'comments': []
			'commentcount': 0)

		initialize: ->
			super
	
		set: (attrs, options) ->
			if attrs.newtags? and not (attrs.newtags instanceof cTag)
				attrs.newtags = new cTag attrs.newtags

			if attrs.comments? and not (attrs.comments instanceof cComment)
				attrs.comments = new cComment attrs.comments

			super