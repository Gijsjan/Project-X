define (require) ->
	ContentFull = require 'models/content.full'

	class NoteMin extends ContentFull
		
		'type': 'note'

		'defaults':	_.extend({}, ContentFull::defaults, 
			'body': '')