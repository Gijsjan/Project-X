_ = require 'underscore'
async = require 'async'
BaseModel = require './base'
db = require '../MySQLConnection'

class Content extends BaseModel

	'type': 'content'

	'defaultAttributes': 
		'title': ''
		'type': 
			'id': ''
			'value': ''
		'created': ''
		'updated': ''
		'groups': []
		'users': []
	
	'defaults': -> _.extend {}, BaseModel::defaults, @defaultAttributes

	fetchOptions: ->
		'tables': [@type, 'content_type', 'content']
		'fields': ['`content`.*', '`'+@type+'`.*', '`content_type`.value as type_value']
		'where': "	`"+@type+"`.`id` = '"+@id+"' AND 
					`content`.`id` = '"+@id+"' AND 
					`content_type`.id = `content`.type_id"

	beforeSave: (callback) ->
		attributes = {}

		for own attribute, value of @defaultAttributes
			attributes[attribute] = @get attribute

		attributes.type_id = @get('type').id
		attributes.id = @id if not @isNew()
		
		delete attributes.users
		delete attributes.groups
		delete attributes.type

		callback attributes

	afterSave: (callbackk) ->
		content_id = @id
		
		async.series
			'1': (callback) =>
				sqlq = "DELETE FROM `content__group` WHERE `content_id` = '" + content_id + "'"
				db.run sqlq, callback(null, 1)
			'2': (callback) =>
				sqlq = "DELETE FROM `content__person` WHERE `content_id` = '" + content_id + "'"
				db.run sqlq, callback(null, 2)
			'3': (callback) =>
				values = []

				for group_id in _.pluck(@get('groups'), 'id')
					values.push "('"+content_id+"', '"+group_id+"')"

				if values.length > 0
					sqlq = "INSERT INTO `content__group` VALUES "
					sqlq = sqlq + values.join()

					db.run sqlq, callback(null, 3)
				else
					callback(null, 3)
			'4': (callback) =>
				values = []

				for person_id in _.pluck(@get('users'), 'id')
					values.push "('"+content_id+"', '"+person_id+"')"

				if values.length > 0
					sqlq = "INSERT INTO `content__person` VALUES "
					sqlq = sqlq + values.join()

					db.run sqlq, callback(null, 4)
				else
					callback(null, 4)
			, (err, results) =>
				console.log 'callback'
				console.log @attributes
				callbackk @attributes


module.exports = Content