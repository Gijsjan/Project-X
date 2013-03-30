define (require) ->
	cTrips = require 'collections/content/carpool/trip'
	List = require 'views/list'

	class TripList extends List

		initialize: ->
			@items = new cTrips [], 'carpool_id': @options.carpool_id

			super