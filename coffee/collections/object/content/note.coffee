define (require) ->
	Backbone = require 'backbone'
	mNote = require 'models/object/content/note'

	Backbone.Collection.extend

		model: mNote
	
		url: 'api/notes'