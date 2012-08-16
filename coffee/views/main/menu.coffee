define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!html/main/menu.html'

	Backbone.View.extend

		tagName: 'nav'

		id: 'main'

		render: ->
			@$el.html _.template tpl
			@