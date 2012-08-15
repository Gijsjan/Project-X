define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tplLogin = require 'text!templates/main/login.html'

	Backbone.View.extend
		id: 'login-form'
		events:
			"click #form-submit": "submitForm"
			"keyup input#password": "checkInputKey"
		checkInputKey: (e) ->
			if e.keyCode is 13
				@submitForm()
		submitForm: ->
			$.post	'/api/login',
					username: $('#username').val()
					password: $('#password').val(),
					(data) =>
						href = if @options.href then @options.href else '' #
						@navigate(href);
		render: ->
			@$el.html _.template(tplLogin)
			@