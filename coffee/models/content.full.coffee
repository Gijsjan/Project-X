define (require) ->
	BaseCollection = require 'collections/base'
	ContentMin = require 'models/content.min'
	Groups = require 'collections/group'
	Users = require 'collections/people'

	class ContentFull extends ContentMin

		'defaults':	_.extend({}, ContentMin::defaults, 
			'access': new BaseCollection()
			'groups': new Groups()
			'users': new Users())

		set: (attributes, options) ->
			if _.isObject attributes and (attributes.groups? or attributes.users?)
				console.log 'PersonFull.set: attributes is an object and has "groups" or "users", but nothing is implemented for that! FIX'
				console.log attributes.groups
				console.log attributes.users

			if attributes is 'groups'
				groups = @get 'groups'
				groups.reset options
			if attributes is 'users'
				users = @get 'users'
				users.reset options
			else
				super

		parse: (attributes) ->
			attributes.groups = new Groups attributes.groups, 'parse': true
			attributes.users = new Users attributes.users, 'parse': true

			super