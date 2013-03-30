define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'ViewManager'

	class Base extends Backbone.View

		initialize: ->
			viewManager.register @

		navigate: (location) ->
			router = new Backbone.Router
			router.navigate location, 'trigger': true

		isContent: ->
			content = if @_listInheritance().indexOf('Content') > 0 then true else false

		
		_listInheritance: ->
			obj = @constructor			
			classes = [obj.name]

			while obj.__super__?
				classes.push obj.__super__.constructor.name
				obj = obj.__super__.constructor

			classes
