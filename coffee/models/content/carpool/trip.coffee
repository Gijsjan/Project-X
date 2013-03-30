define (require) ->
	Base = require 'models/base'

	class CarpoolTrip extends Base
		
		@type: 'carpool_trip'

		defaults: -> _.extend {}, Base::defaults,
			'type': 'carpool_trip'
			'previous_mileage': ''
			'current_mileage': ''
			'datetime': ''