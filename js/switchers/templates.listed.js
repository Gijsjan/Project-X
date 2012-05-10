define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/event/listed',
	'text!../../../templates/link/listed',
	'text!../../../templates/video/listed',
	'text!../../../templates/document/listed',
	'text!../../../templates/note/listed'
], function($, _, Backbone, tplListedEvent, tplListedLink, tplListedVideo, tplListedDocument, tplListedNote) {
	return {
		'event': tplListedEvent,
		'link': tplListedLink,
		'video': tplListedVideo,
		'document': tplListedDocument,
		'note': tplListedNote
	};
});