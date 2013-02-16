BaseCollection = require './base'
mContent = require '../models/content'

class Content extends BaseCollection

	'model': mContent

	fetchOptions: ->
		'tables': [@type, 'content_type', 'content']
		'fields': ['`content`.*', '`'+@type+'`.*', '`content_type`.value as type_value']
		'where': "	`"+@type+"`.`id` = `content`.`id` AND 
					`content_type`.id = `content`.type_id"
	
module.exports = Content