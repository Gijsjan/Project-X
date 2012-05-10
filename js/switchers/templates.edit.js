define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/event/edit',
	'text!../../../templates/link/edit',
	'text!../../../templates/video/edit',
	'text!../../../templates/document/edit',
	'text!../../../templates/note/edit'
], function($, _, Backbone, tplEvent, tplLink, tplVideo, tplDocument, tplNote) {
	return {
		'event': tplEvent,
		'link': tplLink,
		'video': tplVideo,
		'document': tplDocument,
		'note': tplNote
	};
});