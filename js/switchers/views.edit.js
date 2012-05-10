define([
    'jquery',
    'underscore',
    'backbone',
    'views/event/edit',
	'views/link/edit',
	'views/video/edit',
	'views/document/edit',
	'views/note/edit'
], function($, _, Backbone, vEvent, vLink, vVideo, vDocument, vNote) {
	return {
		'event': vEvent,
		'link': vLink,
		'video': vVideo,
		'document': vDocument,
		'note': vNote
	};
});