define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	mOrganisation = require 'models/object/group/organisation'

	Backbone.Collection.extend

		model: mOrganisation

		url: 'api/organisations'