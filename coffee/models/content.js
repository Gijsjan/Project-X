define([
	'underscore',
	'backbone',
	'collections/tag',
	'models/object'
], function(_, Backbone, TagCollection, mObject){
	return mObject.extend({
		'defaults': _.extend({}, mObject.prototype.defaults, {
			'newtags': []
		}),
		set: function(attributes, options) {
			//var a = [];


			if (attributes.newtags !== undefined && !(attributes.newtags instanceof TagCollection)) {
				attributes.newtags = new TagCollection(attributes.newtags);
			}
			
////////////////remove App.
/*
			if (attributes.tags !== undefined && !(attributes.tags instanceof App.Collections.Tags)) {
				_.each(attributes.tags, function(tag) { a.push({'name': tag}); }); // add name to tag for model
				attributes.tags = new App.Collections.Tags(a); a = [];
			}
			if (attributes.countries !== undefined && !(attributes.countries instanceof App.Collections.Tags)) {
				_.each(attributes.countries, function(country) { a.push({'name': country}); }); // add name to tag for model
				attributes.countries = new App.Collections.Tags(a); a = [];
			}
			if (attributes.comments !== undefined && !(attributes.comments instanceof App.Collections.Comments)) attributes.comments = new App.Collections.Comments(attributes.comments);
			if (attributes.commentcount !== undefined && attributes.commentcount === null) attributes.commentcount = 0;
*/
			return Backbone.Model.prototype.set.call(this, attributes, options);
		}
	});

});

