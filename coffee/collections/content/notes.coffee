define (require) ->
	BaseCollection = require 'collections/base'
	mNote = require 'models/content/note'

	class cNote extends BaseCollection

		model: mNote
	
		url: '/b/db/notes'