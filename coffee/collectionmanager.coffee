define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	h = require 'helper'
	
	class CollectionManager		
		collections: {}
		fetching: {}

		register: (url, response) ->
			@collections[url] = response
			@fetching[url] = false