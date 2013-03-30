define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	h = require 'helper'
	
	class CollectionManager		
		
		'collections': {}

		# Response is an array of objects. First the objects are deepCopied,
		# then put back in an array.
		register: (url, response) ->
			response = h.deepCopy response
			
			values = []
			for own key, value of response
				values.push value

			@collections[url] = values

		# Goes through each stored (raw) collection with the id of a model
		# If the id is found in the raw collection, the collection is removed
		# Better would be to update the model in the collection, 
		# but the new data is not yet available
		removeChangedCollections: (id) ->
			# console.log 'CollectionManager.removeChangedCollections()'
			for own url, data of @collections
				found = _.find data, (obj) ->
					obj.id is id
				delete @collections[url] if found?

		removeCollections: ->
			@collections = {}

	new CollectionManager()