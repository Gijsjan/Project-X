define (require) ->
	_ = require 'underscore'
	mGroup = require 'models/object/group/group'
	#cOrganisation = require 'collections/object/group/organisation'

	mGroup.extend

		'urlRoot': '/api/departement'

		'defaults': _.extend({}, mGroup.prototype.defaults,
			'type': 'departement'
			'organisations': '')
		###
		set: (attributes, options) ->
			if attributes.organisations? and not (attributes.organisations instanceof cOrganisation)
				attributes.organisations = new cOrganisation attributes.organisations

			mGroup.prototype.set.call @, attributes, options
		###