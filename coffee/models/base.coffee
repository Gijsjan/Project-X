define (require) ->
	Backbone = require 'backbone'
	collectionManager = require 'CollectionManager'
	modelManager = require 'ModelManager'
	ajax = require 'AjaxManager'
	ev = require 'EventDispatcher'
	hlpr = require 'helper'

	class Base extends Backbone.Model

		urlRoot: -> '/b/db/' + @type

		save: ->
			super {},
				success: (model, response, options) => ev.trigger 'modelSaved', model
				error: (model, xhr, options) => ev.trigger xhr.status+''

		isContent: ->
			l = @_listInheritance()
			
			if l.indexOf('Content') > 0 or l.indexOf('ContentFull') > 0 or l.indexOf('ContentMin') > 0
				content = true 
			else 
				content = false

			content

		
		_listInheritance: ->
			obj = @constructor			
			classes = [obj.name]

			while obj.__super__?
				classes.push obj.__super__.constructor.name
				obj = obj.__super__.constructor

			classes
