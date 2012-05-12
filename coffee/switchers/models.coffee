define [
	    'models/event'
		'models/link'
		'models/video'
		'models/document'
		'models/note'
	], (mEvent, mLink, mVideo, mDocument, mNote) ->
		'event': mEvent
		'link': mLink
		'video': mVideo
		'document': mDocument
		'note': mNote