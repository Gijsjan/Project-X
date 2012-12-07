define (require) ->
	vList = require 'views/list'

	class vOrganisationList extends vList

		initialize: ->
			@type = 'organisations'

			super