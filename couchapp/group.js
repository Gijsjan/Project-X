var couchapp = require('couchapp'), 
	path = require('path');

ddoc = {
	_id: '_design/group',
	views: {}, 
	lists: {}, 
	shows: {} 
};

module.exports = ddoc;

ddoc.views.departements = {
	map: function(doc) {
		if(doc.type == 'group/departement') {
			emit(doc.slug, doc.title);
		}
	}
};

ddoc.validate_doc_update = function (newDoc, currentDoc, userCtx) {
	/*
	var required_attrs = {};

	function require(field, message) {
		if (!newDoc[field]) required_attrs[field] = message;
	}

	if (newDoc.type == "group") {
		require('title', "Don't forget the title!");
		require('description', "We need a description!");
		require('goal', "What would a group be without a goal?");

		throw({forbidden : required_attrs});
	}
	*/
};