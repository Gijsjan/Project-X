define (require) ->
	# _ = require 'underscore'
	Backbone = require 'backbone'
	BaseModel = require 'models/base'
	collectionManager = require 'CollectionManager'

	class BaseCollection extends Backbone.Collection

		'model': BaseModel

		getType: ->
			model = new @model
			model.type

		initialize: (models = [], options = {}) ->
			@url = options.url if options.url?
			@type = @getType()

		removeByCid: (cid) ->
			model = @get(cid)
			@remove model

		fetch: (callback) ->
			super
				success: (collection, response, options) -> callback collection, response, options
				error: (collection, xhr, options) -> console.log xhr
		
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