define (require) ->
	Backbone = require 'backbone'
	mComment = require 'models/object/comment'

	class cComment extends Backbone.Collection

		model: mComment

		url: '/api/comments'