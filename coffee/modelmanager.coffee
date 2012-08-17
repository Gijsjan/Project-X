define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	
	class ModelManager		
		constructor: ->
			@models = new Backbone.Collection()

		register: (model) ->
			# console.log 'ModelManager -> registering'
			
			old = @models.get(model.id) # Look in the collection if an earlier version of the model exists
			@unregister old if old? # Remove the old model cuz model in collection is not always (?!?!) a reference to the passed model

			@models.add model

		unregister: (model) ->
			#console.log 'ViewManager => unregistering '+model.cid

			@models.remove model		