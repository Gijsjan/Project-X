define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	tplTagList = require 'text!html/tag/list.html'

	class vTagList extends BaseView
		
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