define (require) ->
	BaseView = require 'views/base'
	tplLogin = require 'text!html/main/login.html'
	hlpr = require 'helper'

	class vLogin extends BaseView

		events:
			"click button.btn-primary": "submitForm"
			"keyup input#password": "onKeyup"
		
		onKeyup: (e) ->
			if e.keyCode is 13
				@submitForm()
				@$('.modal').modal('hide')
		
		submitForm: ->
			if @valid()
				require('models/CurrentUser').login $('#username').val(), $('#password').val()

		initialize: ->

		render: ->
			@$el.html _.template(tplLogin)

			@$('.modal').modal
				'backdrop': 'static'

			@$('.modal').on 'shown', => @$('#username').focus() # focus only works after animation has finished

			@

		valid: ->
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
