var couchapp = require('couchapp'),
	path = require('path');

ddoc = {
	_id: '_design/content',
	views: {},
	lists: {},
	shows: {}
};

module.exports = ddoc;

ddoc.views.formats = {
	map: function(doc) {
		if(doc.type == 'content/format') {
			emit(doc.title, doc);
		}
	}
};

ddoc.validate_doc_update = function (newDoc, currentDoc, userCtx) {
	/*
	var required_attrs = {};

	function require(field, message) {
		if (!newDoc[field]) required_attrs[field] = message;
	}

	if (newDoc.type == "format") {
		require('title', "Don't forget the title!");
		require('description', "We need a description!");
		require('goal', "What would a format be without a goal?");

		throw({forbidden : required_attrs});
	}
	*/
};