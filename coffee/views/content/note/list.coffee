define (require) ->
	BaseView = require 'views/base'
	vList = require 'views/list'

	class vNoteList extends vList

		initialize: ->
			@type = 'notes'

			super