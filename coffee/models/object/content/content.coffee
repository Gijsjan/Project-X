define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'
	cTag = require 'collections/object/tag'
	cComment = require 'collections/object/comment'
	hlpr = require 'helper'

	class mContent extends mObject

		'urlRoot': '/db/projectx/'

		defaults: _.extend({}, mObject.prototype.defaults,
			'show': true
			'newtags': []
			'comments': []
			'commentcount': 0)

		initialize: ->
			super

		# fetch: (options) ->
		# 	console.log 'mContent.fetch()'

		parse: (response) ->
			# console.log 'mContent.parse()'

			if response.rev? # if response is document than _rev is present, on update rev is present
				response._rev = response.rev
				delete response.rev

			response.id = response._id if response._id?

			response
	
		set: (attrs, options) ->
			# console.log 'mContent.set()'

			if attrs.newtags? and not (attrs.newtags instanceof cTag)
				attrs.newtags = new cTag attrs.newtags

			if attrs.comments? and not (attrs.comments instanceof cComment)
				attrs.comments = new cComment attrs.comments

			super