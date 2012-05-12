define [
	    'text!../../../templates/event/edit'
		'text!../../../templates/link/edit'
		'text!../../../templates/video/edit'
		'text!../../../templates/document/edit'
		'text!../../../templates/note/edit'
	], (tplEvent, tplLink, tplVideo, tplDocument, tplNote) ->
		'event': tplEvent
		'link': tplLink
		'video': tplVideo
		'document': tplDocument
		'note': tplNote