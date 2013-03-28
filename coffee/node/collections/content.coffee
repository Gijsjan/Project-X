_ = require 'lodash'
BaseCollection = require './base'
mContent = require '../models/content'

class Content extends BaseCollection

	'model': mContent

	initialize: ->
		@model = require('../models/content') if _.isEmpty @model

		super

	fetchOptions: ->
		'tables': [@type, 'content_type', 'content']
		'fields': ['`content`.*', '`'+@type+'`.*', '`content_type`.value as type_value']
		'where': "	`"+@type+"`.`id` = `content`.`id` AND 
					`content_type`.id = `content`.type_id"
	
module.exports = Content