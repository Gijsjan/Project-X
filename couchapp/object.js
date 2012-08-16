var couchapp = require('couchapp'), 
	path = require('path');

ddoc = {
	_id: '_design/object',
	views: {}, 
	lists: {}, 
	shows: {} 
};

module.exports = ddoc;

ddoc.views.countries = {
	map: function(doc) {
		if(doc.type == 'object/country') {
			emit(doc.slug, doc.name);
		}
	}
};

ddoc.validate_doc_update = function (newDoc, currentDoc, userCtx) {
	/*
	var required_attrs = {};

	function require(field, message) {
		if (!newDoc[field]) required_attrs[field] = message;
	}

	if (newDoc.type == "object") {
		require('title', "Don't forget the title!");
		require('description', "We need a description!");
		require('goal', "What would a object be without a goal?");

		throw({forbidden : required_attrs});
	}
	*/
};