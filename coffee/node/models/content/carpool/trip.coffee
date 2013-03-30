_ = require 'lodash'
BaseModel = require '../../base'

class CarpoolTrip extends BaseModel

	'type': 'carpool_trip'

	'defaultAttributes':
		'previous_mileage': ''
		'current_mileage': ''
		'datetime': ''

	'defaults': -> _.extend {}, BaseModel::defaults(), @defaultAttributes

	### FETCH ###

	### /FETCH ###

	### SAVE ###

	### /SAVE ###

module.exports = CarpoolTrip