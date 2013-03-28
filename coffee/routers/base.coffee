define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'ViewManager'
	ev = require 'EventDispatcher'
	Switcher = require 'switchers/switcher'
	List = require 'views/list'

	class BaseRouter extends Backbone.Router

		'breadcrumbs': {}

		'view': {}

		initialize: ->
			@on 'all', (eventName) =>		
				if eventName.substr(0, 6) is "route:"	
					ev.trigger 'newRoute', @breadcrumbs
					@breadcrumbs = {}

					viewManager.show @view

		list: (type) ->
			@breadcrumbs[type] = ''

			@view = new List 'type': type 

		# remove all together!
		_getModel: (type, id) ->
			model = if id? then new Switcher.Models[type] 'id': id else new Switcher.Models[type]()
			# MOVE INSIDE MODEL:
			# model.set 'content_type',
			# 	'id': @type_ids[type]
			# 	'value': type

			model