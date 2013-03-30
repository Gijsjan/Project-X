define (require) ->
	BaseCollection = require 'collections/base'
	mOrganisation = require 'models/group/organisation'

	class cOrganisations extends BaseCollection

		model: mOrganisation
	
		url: '/b/db/organisations'