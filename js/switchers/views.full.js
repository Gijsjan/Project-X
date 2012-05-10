define([
    'jquery',
    'underscore',
    'backbone',
    'views/event/full',
	'views/link/full',
	'views/video/full',
	'views/document/full',
	'views/note/full'
], function($, _, Backbone, vEventFull, vLinkFull, vVideoFull, vDocumentFull, vNoteFull) {
	return {
		'event': vEventFull,
		'link': vLinkFull,
		'video': vVideoFull,
		'document': vDocumentFull,
		'note': vNoteFull
	};
});