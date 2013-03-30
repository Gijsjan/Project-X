define (require) ->
	BaseCollection = require 'collections/base'
	mNote = require 'models/content/note.min'

	class Notes extends BaseCollection

		model: mNote
	
		url: '/b/db/note'