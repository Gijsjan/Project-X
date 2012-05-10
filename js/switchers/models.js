define([
    'models/event',
	'models/link',
	'models/video',
	'models/document',
	'models/note'
], function(EventModel, LinkModel, VideoModel, DocumentModel, NoteModel) {
	return {
		'event': EventModel,
		'link': LinkModel,
		'video': VideoModel,
		'document': DocumentModel,
		'note': NoteModel
	};
});