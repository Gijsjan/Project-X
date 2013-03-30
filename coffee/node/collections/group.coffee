_ = require 'lodash'
BaseCollection = require './base'
Group = require '../models/group'

class Groups extends BaseCollection

	'model': Group

	initialize: ->
		@model = require('../models/group') if _.isEmpty @model

		super

	fetchOptions: ->
		'tables': ['group', 'group_type']
		'fields': ['`group`.*', '`group_type`.value as type_value']
		'where': "`group_type`.id = `group`.type_id"

module.exports = Groups


