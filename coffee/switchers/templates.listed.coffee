define [
	    'text!../../../templates/event/listed'
		'text!../../../templates/link/listed'
		'text!../../../templates/video/listed'
		'text!../../../templates/document/listed'
		'text!../../../templates/note/listed'
	], (tplListedEvent, tplListedLink, tplListedVideo, tplListedDocument, tplListedNote) ->
		'event': tplListedEvent
		'link': tplListedLink
		'video': tplListedVideo
		'document': tplListedDocument
		'note': tplListedNote