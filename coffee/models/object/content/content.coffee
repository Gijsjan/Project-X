define (require) ->
	_ = require 'underscore'
	mObject = require 'models/object/object'
	cTag = require 'collections/object/tag'
	cComment = require 'collections/object/comment'
	hlpr = require 'helper'

	class mContent extends mObject

		# 'urlRoot': '/db/projectx/'

		# defaults: _.extend({}, mObject.prototype.defaults,
		# 	'owner': ""
		# 	'editors': []
		# 	'tags': []
		# 	'comments': [])

		# initialize: ->
		# 	super
	
		# set: (attrs, options) ->
		# 	# console.log 'mContent.set()'

		# 	if attrs.tags? and not (attrs.tags instanceof cTag)
		# 		attrs.tags = new cTag attrs.tags

		# 	if attrs.comments? and not (attrs.comments instanceof cComment)
		# 		attrs.comments = new cComment attrs.comments

		# 	super