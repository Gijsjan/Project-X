define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class BaseView extends Backbone.View

		initialize: ->
			# console.log 'BaseView -> registering'
			@globalEvents.trigger 'registerView', @

		unregister: ->
			# console.log 'BaseView -> unregistering'
			@globalEvents.trigger 'unregisterView', @
