_ = require 'lodash'
Content = require '../content'

class Carpool extends Content

	'type': 'carpool'

	relations: -> _.extend {}, Content::relations(),
		'trips': 
			'key': 'carpool_trip'
			'type': 'one2many'

	'defaultAttributes':
		'model': ''
		'numberplate': ''
		'initial_mileage': ''
		'trips': []

	'defaults': -> _.extend {}, Content::defaults(), @defaultAttributes

	### FETCH ###

	### /FETCH ###

	### SAVE ###

	beforeSave: (callback) ->
		attributes = {}

		for own attribute, value of @defaultAttributes
			attributes[attribute] = @get attribute

		delete attributes.type

		attributes.id = @id if not @isNew()


		callback attributes

	# call NOP afterSave to prevent the afterSave from Content to fire
	afterSave: (cb) -> cb()

	### /SAVE ###

module.exports = Carpool