define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tplLogin = require 'text!html/main/login.html'

	Backbone.View.extend

		events:
			"click button.btn-primary": "submitForm"
			"keyup input#password": "onKeyup"
		
		onKeyup: (e) ->
			if e.keyCode is 13
				@submitForm()
				@$('.modal').modal('hide')
		
		submitForm: ->
			if @validate()
				$.ajax
					type: 'POST'
					dataType: 'json'
					url: '/db/_session'
					data:
						'name': $('#username').val()
						'password': $('#password').val()
					success: (data) =>
						@globalEvents.trigger 'loginsuccess' # Fire event to re-render the menu
						@navigate @routeHistory.pop()
					error: (data) =>
						data = $.parseJSON(data.responseText)
						@$('#login-alert').html(data.reason).show()
						@$('button.btn-primary').html 'Try again!'
		
		render: ->
			@$el.html _.template(tplLogin)

			@$('.modal').modal
				'backdrop': 'static'

			@

		validate: ->
			valid = true
			@$('#username-alert').css 'visibility', 'hidden'
			@$('#password-alert').css 'visibility', 'hidden'

			if @$('#username').val() is ''
				@$('#username-alert').html 'Enter a username'
				@$('#username-alert').css 'visibility', 'visible'
				valid = false
			if @$('#password').val() is ''
				@$('#password-alert').html 'Enter a password'
				@$('#password-alert').css 'visibility', 'visible'
				valid = false

			return valid