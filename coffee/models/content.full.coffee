define (require) ->
	BaseCollection = require 'collections/base'
	ContentMin = require 'models/content.min'

	class ContentFull extends ContentMin

		defaults: ->
			_.extend {}, ContentMin::defaults(), 'access': new BaseCollection()

		set: (attributes, options) ->
			
			if attributes is 'access'
				access = @get 'access'
				access.reset options
			# else if _.isObject(attributes) and attributes.access?
			# 	access.reset attributes.access
			else
				super

		parse: (attributes) ->
			attributes.access = new BaseCollection attributes.access, 'parse': true

			super