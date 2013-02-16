_ = require 'underscore'
Content = require '../content'

class Note extends Content

	'type': 'note'

	'defaultAttributes': 
		'body': ''

	'defaults': -> _.extend {}, Content::defaults, @defaultAttributes

	beforeSave: (callback) ->
		attributes = {}

		for own attribute, value of @defaultAttributes
			attributes[attribute] = @get attribute

		attributes.id = @id if not @isNew()

		callback attributes

	# call NOP afterSave to prevent the afterSave from Content to fire
	afterSave: (callback) -> callback @attributes

module.exports = Note