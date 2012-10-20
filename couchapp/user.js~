var couchapp = require('couchapp'),
	path = require('path');

ddoc = {
	_id: '_design/user',
	views: {},
	lists: {},
	shows: {}
};

module.exports = ddoc;

ddoc.views.users = {
	map: function(doc) {
		if(doc.type == 'user') {
			emit(doc._id, doc);
		}
	}
};

ddoc.validate_doc_update = function (newDoc, currentDoc, userCtx) {

};
