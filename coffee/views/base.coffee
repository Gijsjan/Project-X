define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'ViewManager'

	class BaseView extends Backbone.View

		initialize: ->
			viewManager.register @

		navigate: (location) ->
			router = new Backbone.Router
			router.navigate location, 'trigger': true