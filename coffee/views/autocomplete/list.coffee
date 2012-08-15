define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!templates/autocomplete/list.html'

	Backbone.View.extend

		tagName: 'ul'

		className: 'ac-selected'

		events:
			"click span.del": "deleteSelected"

		deleteSelected: (e) ->
			id = $(e.currentTarget).attr 'data-id'
			@collection.remove @collection.get(id)

		render: ->
			html = _.template tpl, 
				'selected': @collection

			@$el.html html

			@