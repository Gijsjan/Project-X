var couchapp = require('couchapp'), 
	path = require('path');

ddoc = {
	_id: '_design/object',
	updates: {},
	views: {}, 
	lists: {}, 
	shows: {} 
};

module.exports = ddoc;

ddoc.updates = {
	"addrelation": function (doc, req) {
		var type = req.query.type;
		var id = req.query.id;

		if (!doc.relations)
			doc.relations = {}
		if (!doc.relations[type])
			doc.relations[type] = {}

		doc.relations[type][id] = {}
		
		return [doc, 'added relation'];
	},
	"removerelation": function (doc, req) {
		var type = req.query.type;
		var id = req.query.id;

		delete doc.relations[type][id]
		
		return [doc, 'removed relation'];
	}
}

ddoc.views.country = {
	map: function(doc) {
		if(doc.type == 'object/country') {
			emit(doc.name, doc.slug);
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
