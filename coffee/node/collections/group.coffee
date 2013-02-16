_ = require 'underscore'
BaseCollection = require './base'
Group = require '../models/group'

class Groups extends BaseCollection

	'model': Group

	initialize: ->
		@model = require('../models/group') if _.isEmpty @model

		super

	fetchBy: (args) ->
		[table, id, callback] = [args.table, args.id, args.callback]

		relation_table = 'group__'+table

		@fetch callback,
			'tables': ['group', 'group_type', relation_table]
			'fields': ['`group`.*', '`group_type`.value as type_value']
			'where': "`group_type`.id = `group`.type_id AND `"+relation_table+"`.group_id = `group`.id AND `"+relation_table+"`.person_id = '"+id+"'"		

	fetchOptions: ->
		'tables': ['group', 'group_type']
		'fields': ['`group`.*', '`group_type`.value as type_value']
		'where': "`group_type`.id = `group`.type_id"

module.exports = Groups


