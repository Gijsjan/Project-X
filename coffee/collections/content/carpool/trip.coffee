define (require) ->
	BaseCollection = require 'collections/base'
	Trip = require 'models/content/carpool/trip'

	class CarpoolTrips extends BaseCollection

		'model': Trip
	
		url: -> '/b/db/carpool/'+@carpool_id+'/trips'

		initialize: (models = [], options = {}) ->
			@carpool_id = options.carpool_id

			super