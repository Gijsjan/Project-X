define (require) ->
	Backbone = require 'backbone'
	mDocument = require 'models/object/content/document'

	Backbone.Collection.extend

		model: mDocument
	
		url: 'api/documents'