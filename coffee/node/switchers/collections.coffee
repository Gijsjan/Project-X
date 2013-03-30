class Collections

	@collections:
		'content': '../collections/content'
		'note': '../collections/content/note'
		'carpool': '../collections/content/carpool'
		'carpool_trip': '../collections/content/carpool/trip'
		'group': '../collections/group'
		'person': '../collections/person'

	@get: (type) ->
		collection = require @collections[type]
		new collection()

module.exports = Collections