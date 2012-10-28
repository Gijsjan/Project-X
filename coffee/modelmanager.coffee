define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	
	class ModelManager		
		models: {}

		register: (obj) ->
			@models[obj.id] = obj