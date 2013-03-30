_ = require 'lodash'
async = require 'async'
BaseModel = require './base'
Content = require './content'
Groups = require '../collections/group'
Notes = require '../collections/content/note'
db = require '../MySQLConnection'
RelationManager = require '../RelationManager'

class Person extends BaseModel

	'type': 'person'

	relations: ->
		'groups': 
			'key': 'group'
			'type': 'many2many'
		'content':
			'key': 'content'
			'type': 'many2many'

	'defaultAttributes':
		'type': 'person'
		'username': ''
		'email': ''
		'password': ''
		'groups': []
		'content': []
	
	defaults:	-> _.extend {}, BaseModel::defaults(), @defaultAttributes

	initialize: ->
		if @id? and isNaN(parseInt(@id))
			console.log 'setting usernmae'+@id
			@set 'username', @id
			@unset 'id'

	### FETCH ###

	fetchOptions: ->
		if not _.isEmpty(@get('username'))
			where = "`person`.username = '"+@get('username')+"'"
		else
			where = "`person`.id = '"+@id+"'"
		
		'tables': 'person'
		'where': where

	parse: (attributes) ->
		attributes.title = attributes.username

		attributes

	afterFetch: (cb) -> RelationManager.fetch @, cb

	### /FETCH ###

	### SAVE ###
	
	beforeSave: (callback) ->
		attributes = _.extend {}, @attributes # copy @attributes

		delete attributes.type
		delete attributes.title
		delete attributes.groups
		delete attributes.content

		callback attributes

	afterSave: (cb) ->
		person_id = @id
		values = []
		sqlq = "DELETE FROM `group__person` WHERE `person_id` = '" + person_id + "'"
		
		db.run sqlq, (response) =>
			for group_id in _.pluck(@get('groups'), 'id')
				values.push "('"+group_id+"', '"+person_id+"')"

			if values.length > 0
				sqlq = "INSERT INTO `group__person` VALUES "
				sqlq = sqlq + values.join()

				db.run sqlq, (response) => cb()
			else
				cb()
	### /SAVE ###

module.exports = Person