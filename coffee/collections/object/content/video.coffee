define (require) ->
	Backbone = require 'backbone'
	mVideo = require 'models/object/content/video'

	Backbone.Collection.extend

		model: mVideo
	
		url: 'api/videos'