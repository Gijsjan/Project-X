define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/event/full',
	'text!../../../templates/link/full',
	'text!../../../templates/video/full',
	'text!../../../templates/document/full',
	'text!../../../templates/note/full'
], function($, _, Backbone, tplFullEvent, tplFullLink, tplFullVideo, tplFullDocument, tplFullNote) {
	return {
		'event': tplFullEvent,
		'link': tplFullLink,
		'video': tplFullVideo,
		'document': tplFullDocument,
		'note': tplFullNote
	};
});