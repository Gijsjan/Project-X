define [
	    'views/event/edit'
		'views/link/edit'
		'views/video/edit'
		'views/document/edit'
		'views/note/edit'
	], (vEvent, vLink, vVideo, vDocument, vNote) ->
		'event': vEvent
		'link': vLink
		'video': vVideo
		'document': vDocument
		'note': vNote