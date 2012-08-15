define (require) ->
	_ = require 'underscore'
	mGroup = require 'models/object/group/group'
	cDepartement = require 'collections/object/group/departement'
	cProject = require 'collections/object/group/project'

	mGroup.extend

		'urlRoot': '/api/organisation'

		'defaults': _.extend({}, mGroup.prototype.defaults,
			'type': 'organisation'
			'departements': new cDepartement()
			'projects': new cProject())

		set: (attributes, options) ->
			if attributes.departements? and not (attributes.departements instanceof cDepartement)
				attributes.departements = new cDepartement attributes.departements

			if attributes.projects? and not (attributes.projects instanceof cProject)
				attributes.projects = new cProject attributes.projects

			mGroup.prototype.set.call @, attributes, options