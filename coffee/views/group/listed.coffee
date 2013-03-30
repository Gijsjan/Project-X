define (require) ->
	Listed = require 'views/listed'
	tpl = require 'text!html/group/listed.html'

	class Group extends Listed
		
		render: ->
			super

			rtpl = _.template tpl, @model.toJSON()
			@$('.listed-body').html rtpl

			@