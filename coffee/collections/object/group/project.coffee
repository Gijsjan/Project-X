define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	mProject = require 'models/object/group/project'

	Backbone.Collection.extend

		model: mProject

		url: 'api/projects'