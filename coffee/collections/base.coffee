define (require) ->
	# _ = require 'underscore'
	Backbone = require 'backbone'
	collectionManager = require 'CollectionManager'

	class BaseCollection extends Backbone.Collection

		removeByCid: (cid) ->
			model = @getByCid(cid)
			@remove model
		
		# sync: (method, collection, options) ->
		# 	# console.log 'BaseCollection.sync()'
		# 	storedCollection = collectionManager.collections[@url]

		# 	if method is 'read' and storedCollection?
		# 		options.success(storedCollection)
		# 	else
		# 		Backbone.sync(method, collection, options)
		
		# parse: (response) ->
		# 	# console.log 'BaseCollection.parse()'
		# 	collectionManager.register @url, response

		# 	response