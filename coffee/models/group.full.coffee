define (require) ->
	GroupMin = require 'models/group.min'
	cPerson = require 'collections/people'

	class GroupFull extends GroupMin

		'defaults':	_.extend({}, GroupMin::defaults,
			'members': new cPerson())

		parse: (attributes) ->
			attributes.members = new cPerson attributes.members, 'parse': true

			attributes