define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vFullObject = require 'views/object/full'
	vTagList = require 'views/tag/list'

	vFullObject.extend
		render: ->
			vFullObject.prototype.render.apply @

			tags = new vTagList
				tags: @model.get 'newtags'
			wrapper = $('<div />').addClass 'tags-wrapper'
			wrapper.html tags.render().$el

			@$el.append wrapper

			@