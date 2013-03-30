_ = require 'lodash'
BaseCollection = require './base'
Person = require '../models/person'

class People extends BaseCollection

	'model': Person

	initialize: ->
		@model = require('../models/person') if _.isEmpty @model

		super

module.exports = People