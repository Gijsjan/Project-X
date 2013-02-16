_ = require 'underscore'
BaseModel = require './base'
cPerson = require '../collections/person'
db = require '../MySQLConnection'

class Group extends BaseModel

	'type': 'group'

	'defaults':	_.extend({}, BaseModel::defaults, 
		'title': ''
		'type': 
			'id': ''
			'value': ''
		'members': [])

	fetchOptions: ->
		'tables': ['group', 'group_type']
		'fields': ['`group`.*', '`group_type`.value as type_value']
		'where': "`group`.`id` = '"+@id+"' AND `group_type`.id = `group`.type_id"
	
	afterFetch: (args) ->
		[attributes, callback] =[args.attributes, args.callback]

		members = new cPerson()
		members.fetchBy
			'table': 'group'
			'id': @id
			callback: (response) ->
				attributes.members = response.data
				callback attributes

	parse: (attributes) ->
		attributes.type =
			'id': attributes.type_id
			'value': attributes.type_value

		delete attributes.type_id
		delete attributes.type_value

		attributes


	beforeSave: (callback) ->
		attributes = _.extend {}, @attributes # copy @attributes

		attributes.type_id = @get('type').id
		attributes.id = @id if not @isNew()
		
		delete attributes.members
		delete attributes.type

		callback attributes

	afterSave: (callback) ->
		group_id = @id
		values = []
		sqlq = "DELETE FROM `group__person` WHERE `group_id` = '" + group_id + "'"
		
		db.run sqlq, (response) =>
			for person_id in _.pluck(@get('members'), 'id')
				values.push "('"+group_id+"', '"+person_id+"')"

			if values.length > 0
				sqlq = "INSERT INTO `group__person` VALUES "
				sqlq = sqlq + values.join()

				db.run sqlq, (response) => callback @attributes
			else
				callback @attributes

module.exports = Group