define (require) ->
	GroupMin = require 'models/group.min'
	cPerson = require 'collections/people'
	Content = require 'collections/content'

	class GroupFull extends GroupMin

		'defaults':	_.extend({}, GroupMin::defaults,
			'members': new cPerson()
			'content': new Content())

		parse: (attributes) ->
			attributes.members = new cPerson attributes.members, 'parse': true
			attributes.content = new Content attributes.content, 'parse': true

			attributes