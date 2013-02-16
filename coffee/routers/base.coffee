define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'ViewManager'
	ev = require 'EventDispatcher'

	class BaseRouter extends Backbone.Router

		'breadcrumbs': {}

		'view': {}

		initialize: ->
			@on 'all', (eventName) =>
				if eventName.substr(0, 6) is "route:"				
					ev.trigger 'newRoute', @breadcrumbs

					viewManager.show @view