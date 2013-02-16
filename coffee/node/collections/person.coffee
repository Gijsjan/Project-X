_ = require 'underscore'
BaseCollection = require './base'
Person = require '../models/person'

class People extends BaseCollection

	'model': Person

	initialize: ->
		@model = require('../models/person') if _.isEmpty @model

		super
	
	fetchBy: (args) ->
		[table, id, callback] = [args.table, args.id, args.callback]

		relation_table = if @type > table then table+'__'+@type else @type+'__'+table

		@fetch callback,
			'tables': ['person', relation_table]
			'fields': '`person`.*'
			'where': "`"+relation_table+"`.person_id = `person`.id AND `"+relation_table+"`.group_id = '"+id+"'"		


module.exports = People