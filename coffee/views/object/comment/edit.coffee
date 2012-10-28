# @options.model from vEditObject
# @options.content_id # only if @model.isNew()
# @options.collection # only if @model.isNew()

define (require) ->
	vEditObject = require 'views/object/edit'
	mComment = require 'models/object/comment'
	tpl = require 'text!html/comment/edit.html'

	vEditObject.extend

		events:
			'click span#submit': 'saveComment'

		saveComment: (e) ->
			@model.set 'comment', @$('textarea#comment').val()

			if @model.isNew()
				@model.set 'content_id', @options.content_id

				# save the model to the server
				# the vCommentList listens to the collection add event and re-renders the list
				@model.save {},
					success: (model, response) =>
						@$('textarea#comment').val '' #empty the textarea
						@collection.add model, # add model to the beginning of the collection
							'at': 0
					error: (collection, response) => @globalEvents.trigger response.status+''
			else
				@model.save {},
					success: (model, response) =>
						console.log 'alla'
						# @navigate 'object/'+model.get('content_id')
					error: (collection, response) => @globalEvents.trigger response.status+''
						
