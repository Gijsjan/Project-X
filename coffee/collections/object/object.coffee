define (require) ->
	Backbone = require 'backbone'
	Models = require 'switchers/models'

	class cObject extends Backbone.Collection

		model: (attributes, options) ->
			model = if attributes.type then Models[attributes.type] else Backbone.Model()
			new model attributes, options

		url: '/api/objects' #remove?