define (require) ->
	Backbone = require 'backbone'
	mFormat = require 'models/object/content/format'

	Backbone.Collection.extend

		model: mFormat
	
		url: '/db/projectx/_design/content/_view/formats'