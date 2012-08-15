define (require) ->
	Backbone = require 'backbone'
	mEvent = require 'models/object/content/event'

	Backbone.Collection.extend

		model: mEvent
	
		url: 'api/events'