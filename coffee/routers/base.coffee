define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'ViewManager'
	ev = require 'EventDispatcher'

	class BaseRouter extends Backbone.Router

		'breadcrumbs': {}

		'view': {}

		initialize: ->
			@on 'all', (trigger, args) =>
				ev.trigger 'newRoute', @breadcrumbs

				viewManager.show @view