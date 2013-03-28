_ = require 'lodash'
async = require 'async'
BaseModel = require './base'
BaseCollection = require '../collections/base'
People = require '../collections/person'
Groups = require '../collections/group'
db = require '../MySQLConnection'
RelationManager = require '../RelationManager'

class Content extends BaseModel

	'type': 'content'

	relations: ->
		'people': 
			'key': 'person'
			'type': 'many2many'
		'groups':
			'key': 'group'
			'type': 'many2many'

	'defaultAttributes': 
		'title': ''
		'content_type': 
			'id': ''
			'value': ''
		'created': ''
		'updated': ''
		'access': []
	
	defaults: -> _.extend {}, BaseModel::defaults(), @defaultAttributes

	### FETCH ###

	fetchOptions: ->
		'tables': [@type, 'content_type', 'content']
		'fields': ['`content`.*', '`'+@type+'`.*', '`content_type`.value as type_value']
		'where': "	`"+@type+"`.`id` = '"+@id+"' AND 
					`content`.`id` = '"+@id+"' AND 
					`content_type`.id = `content`.type_id"

	parse: (attributes) ->
		attributes.content_type =
			'id': attributes.type_id
			'value': attributes.type_value

		delete attributes.type_id
		delete attributes.type_value

		attributes

	afterFetch: (cb) ->
		RelationManager.fetch @, =>
			@set 'access', _.union(@get('groups'), @get('people'))
			@unset 'groups'
			@unset 'people'
			cb()

	### /FETCH ###

	### SAVE ###

	beforeSave: (callback) ->
		attributes = {}

		for own attribute, value of @defaultAttributes
			attributes[attribute] = @get attribute

		attributes.type_id = @get('content_type').id
		attributes.id = @id if not @isNew()
		
		delete attributes.access
		delete attributes.type
		delete attributes.content_type

		callback attributes

	afterSave: (cb) ->
		content_id = @id

		groups = _.where(@get('access'), 'type': 'group')
		users = _.where(@get('access'), 'type': 'person')
		
		async.series
			'1': (callback) =>
				sqlq = "DELETE FROM `content__group` WHERE `content_id` = '" + content_id + "'"
				db.run sqlq, (response) -> callback(null, response)
			'2': (callback) =>
				sqlq = "DELETE FROM `content__person` WHERE `content_id` = '" + content_id + "'"
				db.run sqlq, (response) -> callback(null, response)
			'3': (callback) =>
				values = []

				for group in groups
					values.push "('"+content_id+"', '"+group.id+"', '"+group.access+"')"

				if values.length > 0
					sqlq = "INSERT INTO `content__group` VALUES "
					sqlq = sqlq + values.join()

					db.run sqlq, (response) -> callback(null, response)
				else
					callback(null, 3)
			'4': (callback) =>
				values = []

				for person in users
					values.push "('"+content_id+"', '"+person.id+"', '"+person.access+"')"

				if values.length > 0
					sqlq = "INSERT INTO `content__person` VALUES "
					sqlq = sqlq + values.join()
					console.log sqlq
					db.run sqlq, (response) -> callback(null, response)
				else
					callback(null, 4)
			, (err, results) => cb()

	### /SAVE ###


module.exports = Content