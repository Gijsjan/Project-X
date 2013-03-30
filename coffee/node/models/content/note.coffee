_ = require 'lodash'
Content = require '../content'

class Note extends Content

	'type': 'note'

	'defaultAttributes':
		'body': ''

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

module.exports = Note