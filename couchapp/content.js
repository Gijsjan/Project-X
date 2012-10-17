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

ddoc.views.formatSelectors = {
	map: function(doc) {
		if(doc.type == 'content/format') {
			for (var key in doc.shortcut2countries) {
				emit(['country', doc.shortcut2countries[key].value, doc.shortcut2countries[key]], 1);
			}
			for (var key in doc.shortcut2departements) {
				emit(['departement', doc.shortcut2departements[key].value, doc.shortcut2departements[key]], 1);
			}
		}
	},
	reduce: '_sum'
};

ddoc.validate_doc_update = function (newDoc, currentDoc, userCtx) {
	/*
	var required_attrs = {};

	function require(field, message) {
		if (!newDoc[field]) required_attrs[field] = message;
	}
	*/
	function isAdmin() {
		return userCtx.roles.indexOf('_admin') != -1
	}
	function isEditor() {
		return newDoc.editors.indexOf(userCtx.name) != -1
	}
	if (newDoc.type == "content/format") {
		if (newDoc.owner != userCtx.name && !isAdmin() && !isEditor()) {
			throw({unauthorized : newDoc.author+"Only "+userCtx.name+" may edit this document."});
		}	
		//require('title', "Don't forget the title!");
		//require('description', "We need a description!");
		//require('goal', "What would a format be without a goal?");

		
	}
};
