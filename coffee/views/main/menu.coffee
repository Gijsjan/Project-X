define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!templates/main/menu.html'

	Backbone.View.extend

		tagName: 'nav'

		id: 'main'

		render: ->
			@$el.html _.template tpl
			@