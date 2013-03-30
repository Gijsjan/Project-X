define (require) ->
	Edit = require 'views/edit'
	tpl = require 'text!html/content/carpool/edit.html'

	class EditCarpool extends Edit