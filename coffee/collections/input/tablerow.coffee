define (require) ->
	Backbone = require 'backbone'
	mTableRow = require 'models/input/tablerow'

	class cInputTableRow extends Backbone.Collection

		'model': mTableRow