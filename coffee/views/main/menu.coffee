define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	tpl = require 'text!html/main/menu.html'

	class vMenu extends BaseView

		initialize: ->
			@getUser()
			
			@globalEvents.on 'loginsuccess', =>
				@getUser()

		getUser: ->
			$.getJSON '/db/_session', (data) =>
				@username = data.userCtx.name
				@render()

		render: ->
			@$el.html _.template tpl,
				'username': @username
			
			$('body').prepend @$el