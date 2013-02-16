define (require) ->
	BaseCollection = require 'collections/base'
	mGroup = require 'models/group.min'

	class Group extends BaseCollection

		model: mGroup
	
		url: '/b/db/group'