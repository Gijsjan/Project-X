define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	mDepartement = require 'models/object/group/departement'

	Backbone.Collection.extend

		model: mDepartement

		url: 'api/departements'