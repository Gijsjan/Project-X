define (require) ->
	Backbone = require 'backbone'
	collectionManager = require 'CollectionManager'
	modelManager = require 'ModelManager'
	ajax = require 'AjaxManager'
	ev = require 'EventDispatcher'
	hlpr = require 'helper'

	class BaseModel extends Backbone.Model

		urlRoot: -> '/b/db/' + @type

		'defaults':	
			'created': ''
			'updated': ''

		'type': 'base'

		save: ->
			super {},
				success: (model, response, options) => ev.trigger 'modelSaved', model
				error: (model, xhr, options) => ev.trigger xhr.status+''
