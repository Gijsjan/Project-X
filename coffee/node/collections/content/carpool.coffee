_ = require 'lodash'
Content = require '../content'
mCarpool = require '../../models/content/carpool'

class Carpool extends Content
	
	'model': mCarpool

	initialize: ->
		@model = require('../../models/content/carpool') if _.isEmpty @model

		super

module.exports = Carpool