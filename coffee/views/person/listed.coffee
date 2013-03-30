define (require) ->
	vListed = require 'views/listed'
	tpl = require 'text!html/person/listed.html'

	class vListedUser extends vListed
	
		render: ->
			super

			rtpl = _.template tpl, @model.toJSON()
			@$('.listed-body').html rtpl

			@