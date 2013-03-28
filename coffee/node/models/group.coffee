_ = require 'lodash'
BaseModel = require './base'
cPerson = require '../collections/person'
db = require '../MySQLConnection'
RelationManager = require '../RelationManager'

class Group extends BaseModel

	'type': 'group'

	relations: ->
		'members': 
			'key': 'person'
			'type': 'many2many'
		'content':
			'key': 'content'
			'type': 'many2many'

	'defaultAttributes': 
		'type': 'group'
		'group_type': 
			'id': ''
			'value': ''
		'title': ''
		'members': []
		'content': []

	defaults: -> _.extend {}, BaseModel::defaults(), @defaultAttributes

	### FETCH ###

	parse: (attributes) ->
		attributes.group_type =
			'id': attributes.type_id
			'value': attributes.type_value

		delete attributes.type_id
		delete attributes.type_value

		attributes

	fetchOptions: ->
		'tables': ['group', 'group_type']
		'fields': ['`group`.*', '`group_type`.value as type_value']
		'where': "`group`.`id` = '"+@id+"' AND `group_type`.id = `group`.type_id"
	
	afterFetch: (cb) -> 
		RelationManager.fetch @, cb

	### /FETCH ###

	### SAVE ###

	beforeSave: (callback) ->
		attributes = _.extend {}, @attributes # copy @attributes

		attributes.type_id = @get('group_type').id
		attributes.id = @id if not @isNew()
		
		delete attributes.members
		delete attributes.type
		delete attributes.group_type

		callback attributes

	afterSave: (cb) ->
		group_id = @id
		values = []
		sqlq = "DELETE FROM `group__person` WHERE `group_id` = '" + group_id + "'"
		
		db.run sqlq, (response) =>
			for person_id in _.pluck(@get('members'), 'id')
				values.push "('"+group_id+"', '"+person_id+"')"

			if values.length > 0
				sqlq = "INSERT INTO `group__person` VALUES "
				sqlq = sqlq + values.join()

				db.run sqlq, (response) => cb()
			else
				cb()

	### /SAVE ###

module.exports = Group