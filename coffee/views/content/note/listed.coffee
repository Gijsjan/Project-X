define (require) ->
	# _ = require 'underscore'
	vListed = require 'views/listed'
	tpl = require 'text!html/content/note/listed.html'

	class vListedNote extends vListed
		
		render: ->
			super
			
			rtpl = _.template tpl, @model.toJSON()
			@$('.listed-body').html rtpl

			@