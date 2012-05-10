define([
    'jquery',
    'underscore',
    'backbone',
    'collections/event',
	'collections/link',
	'collections/video',
	'collections/document',
	'collections/note'
], function($, _, Backbone, cEvent, cLink, cVideo, cDocument, cNote) {
	return {
		'events': cEvent,
		'links': cLink,
		'videos': cVideo,
		'documents': cDocument,
		'notes': cNote
	};
});