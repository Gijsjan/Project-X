define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	mUser = require 'models/object/user'

	Backbone.Collection.extend

		model: mUser

		url: '/api/users'