define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tplTagList = require 'text!templates/tag/list.html'

	Backbone.View.extend
		tagName: 'ul'
		className: 'tags'
		events:
			'click span.add-tag': 'addTagToSelector'
		addTagToSelector: (e) ->
			tag = e.currentTarget.previousSibling.text
			@globalEvents.trigger 'add-tag-to-selector', tag
		render: ->
			@$el.html _.template(tplTagList, tags: this.options.tags)
			@