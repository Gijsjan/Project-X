define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class BaseView extends Backbone.View

		initialize: ->
			# console.log 'registering'
			@globalEvents.trigger 'registerView', @

		unregister: ->
			# console.log 'unregistering'
			@globalEvents.trigger 'unregisterView', @
