define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	cInputTableRow = require 'collections/input/tablerow'
	hlpr = require 'helper'

	class BaseModel extends Backbone.Model

		sync: (method, model, options) ->
			# console.log 'BaseModel.sync()'

			storedModel = @modelManager.models[@id]

			# If a model is updated, the modelManager is updated on @parse(), but the collectionManager doesn't
			# adjust automagically. When a model is updated, remove collections having given model.
			# If the model is not present in the modelManager, it won't be present in the collectionManager
			@collectionManager.removeChangedCollections(@id) if method is 'update' and storedModel?

			if method is 'read' and storedModel?
				options.success(storedModel)
			else
				Backbone.sync(method, model, options)

		parse: (response) ->
			# console.log 'BaseModel.parse()'
			# console.log response
			@modelManager.register response

			if response.meta? # a !!!collection!!! returns objects with the meta attribute (which hold the bucket and key)
				response.id = response.meta.key
				response.bucket = response.meta.bucket
				delete response.meta

			response