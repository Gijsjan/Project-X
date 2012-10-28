define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	h = require 'helper'
	
	class CollectionManager		
		collections: {}

		register: (url, response) ->
			@collections[url] = h.deepCopy response

		# Goes through each stored (raw) collection with the id of a model
		# If the id is found in the raw collection, the collection is removed
		# Better would be to update the model in the collection, 
		# but the new data is not yet available
		removeChangedCollections: (id) ->
			for own url, data of @collections
				found = _.find data, (obj) -> obj.meta.key is id
				delete @collections[url] if found?