define (require) ->
	moment = require 'moment'
	Views =
		Base: require 'views/base'
		ListedTrip: require 'views/content/carpool/trip/listed'
		DateInput: require 'views/input/date'
		TimeInput: require 'views/input/time'
	HTML =
		TripList: require 'text!html/content/carpool/trip/list.html'

	class TripList extends Views.Base

		initialize: ->
			@render()

		render: ->
			tplr = _.template HTML.TripList, 'moment': moment
			@$el.html tplr

			@collection.each (model) =>
				t = new Views.ListedTrip 'model': model
				@$('.trips').append t.render().$el

			@