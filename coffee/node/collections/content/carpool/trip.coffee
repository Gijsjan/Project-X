_ = require 'lodash'
BaseCollection = require '../../base'
mCarpoolTrip = require '../../../models/content/carpool/trip'

class CarpoolTrips extends BaseCollection
	
	'model': mCarpoolTrip

	initialize: ->
		@model = require('../../models/content/carpool/trip') if _.isEmpty @model

		super

module.exports = CarpoolTrips