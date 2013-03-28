define (require) ->
	Listed = require 'views/listed'
	tpl = require 'text!html/content/carpool/trip/listed.html'

	class ListedTrip extends Listed
		
		render: ->
			super
			
			tplr = _.template tpl, @model.toJSON()
			@$('.listed-body').html tplr

			@