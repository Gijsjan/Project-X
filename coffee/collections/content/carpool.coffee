define (require) ->
	BaseCollection = require 'collections/base'
	Carpool = require 'models/content/carpool.min'

	class Carpools extends BaseCollection

		model: Carpool
	
		url: '/b/db/carpool'