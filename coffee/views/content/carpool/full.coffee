define (require) ->
	Views =
		ContentFull: require 'views/content/full'
		TripList: require 'views/content/carpool/trip/list'
	HTML =
		CarpoolFull: require 'text!html/content/carpool/full.html'

	class Carpool extends Views.ContentFull

		render: ->
			super

			tplr = _.template HTML.CarpoolFull, @model.toJSON()
			@$('.content-body').html tplr

			tripList = new Views.TripList 'collection': @model.get('trips')

			@$('.triplist').html tripList.$el

			@