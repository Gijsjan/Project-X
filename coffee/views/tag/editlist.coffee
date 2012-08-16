define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!html/tag/editlist.html'

	Backbone.View.extend

		events:
			"click span.del-tag": "deleteTag"

		deleteTag: (e) ->
			@options.parent.deleteTag e

		tagName: 'ul'

		className: 'edit-tag-list'

		render: ->
			html = _.template tpl, 
				'tags': @collection

			@$el.html html

			@