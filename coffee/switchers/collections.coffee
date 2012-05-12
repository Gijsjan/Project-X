define [
		'collections/event'
		'collections/link'
		'collections/video'
		'collections/document'
		'collections/note'
	], (cEvent, cLink, cVideo, cDocument, cNote) ->
		'events': cEvent
		'links': cLink
		'videos': cVideo
		'documents': cDocument
		'notes': cNote