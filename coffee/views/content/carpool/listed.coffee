define (require) ->
	Listed = require 'views/listed'
	tpl = require 'text!html/content/carpool/listed.html'

	class ListedCarpool extends Listed
		
		render: ->
			super
			
			tplr = _.template tpl, @model.toJSON()
			@$('.listed-body').html tplr

			@