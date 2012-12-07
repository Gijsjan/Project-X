define (require) ->
	
	class ModelManager		
		
		'models': {}

		register: (obj) ->
			@models[obj.id] = obj

	new ModelManager()