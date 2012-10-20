define (require) ->
	mFormat = require 'models/object/content/format'
	BaseCollection = require 'collections/base'
	# cContent = require 'collections/object/content/content'

	class cFormat extends BaseCollection

		model: mFormat
	
		# url: '/db/projectx/_design/content/_view/formats'

		# sync: (method, collection, options) ->
		# 	# console.log 'cFormat.sync()'

		# 	c = @collectionManager.collections[@url]
		# 	if method is 'read' and c?
		# 		options.success(c)
		# 	else
		# 		Backbone.sync(method, collection, options)