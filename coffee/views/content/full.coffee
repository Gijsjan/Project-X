define (require) ->
	# _ = require 'underscore'
	Full = require 'views/full'
	# vTagList = require 'views/tag/list'
	# vEditComment = require 'views/object/comment/edit'
	# vCommentList = require 'views/object/comment/list.content'
	# mComment = require 'models/object/comment'
	tpl = require 'text!html/content/full.html'

	class Content extends Full

		render: ->
			tplRendered = _.template tpl, @model.toJSON()
			@$el.html tplRendered

			# tags = new vTagList
			# 	'tags': @model.get 'tags'
			# @$('.tags-wrapper').html tags.render().$el
			
			###
			ec = new vEditComment
			#	'object_type': 'comment'
				'className': 'object edit comment'
				'model': new mComment()
				'collection': @model.get 'comments'
				'content_id': @model.get 'id'
			@$('.comments-wrapper').html ec.$el # ec is rendered in the views initialize method depending on the state of the model

			comments = new vCommentList
				'collection': @model.get 'comments'
			@$('.comments-wrapper').append comments.render().$el
			###
			@