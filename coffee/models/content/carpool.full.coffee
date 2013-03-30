define (require) ->
	CarpoolMin = require 'models/content/carpool.min'
	Trips = require 'collections/content/carpool/trip'

	class CarpoolFull extends CarpoolMin

		defaults: -> 
			_.extend {}, CarpoolMin::defaults(), 'trips': new Trips()

		parse: (attributes) ->
			attributes.trips = new Trips attributes.trips, 'parse': true

			super