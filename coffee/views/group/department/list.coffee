define (require) ->
	vList = require 'views/list'

	class vDepartmentList extends vList

		initialize: ->
			@type = 'departments'

			super