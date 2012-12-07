define (require) ->
	vEdit = require 'views/edit'

	class vEditPerson extends vEdit

		# events: _.extend({}, vEditObject.prototype.events,
		# 	'keyup #email': 'createUsername')

		# saveObject: ->
		# 	super # saveObject removes all .error's so call before adding password .error

		# 	# password validation is non standard, because password is not returned from the server
		# 	if $.trim(@$('#password').val()) is ''
		# 		@addValidationError 'password'

		# # Username is created from the e-mail address username will be agijsbro when e-mail address is agijsbro@gmail.com
		# createUsername: ->
		# 	value = @$('#email').val()
		# 	if val = value.indexOf('@')
		# 		value = value.substr(0, val)
				
		# 		@model.set 'username', value, 'silent': true
		# 		@$('#username').val(value)