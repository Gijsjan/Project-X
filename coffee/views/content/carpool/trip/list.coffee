define (require) ->
	cTrips = require 'collections/content/carpool/trip'
	List = require 'views/list'

	class TripList extends List