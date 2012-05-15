define [
		'underscore'
		'backbone'
		'collections/tag'
		'models/object'
	], (_, Backbone, TagCollection, mObject) ->
		mObject.extend
			defaults: _.extend({}, mObject.prototype.defaults, 'newtags': [])
			set: (attributes, options) ->
				if attributes.newtags != undefined and !(attributes.newtags instanceof TagCollection)
					attributes.newtags = new TagCollection(attributes.newtags)

				mObject.prototype.set.call this, attributes, options
