define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	
	class ModelManager		
		models: {}

		register: (model) ->
			if _.isArray(model)
				model.forEach((m) => @models[m.get('id')] = m if m.get('id')?)
			else
				@models[model.get('id')] = model if model.get('id')?