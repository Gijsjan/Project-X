_ = require 'underscore'
BaseModel = require './base'
cGroup = require '../collections/group'
db = require '../MySQLConnection'

class Person extends BaseModel

	'type': 'person'

	'defaults':	_.extend({}, BaseModel::defaults, 
		'username': ''
		'email': ''
		'password': ''
		'groups': [])

	initialize: ->
		if @id? and isNaN(parseInt(@id))
			console.log 'setting usernmae'+@id
			@set 'username', @id
			@unset 'id'

	fetchOptions: ->
		if not _.isEmpty(@get('username'))
			where = "`person`.username = '"+@get('username')+"'"
		else
			where = "`person`.id = '"+@id+"'"
		
		'tables': 'person'
		'where': where

	afterFetch: (args) ->
		[attributes, callback] =[args.attributes, args.callback]
		groups = new cGroup()
		groups.fetchBy
			'table': 'person'
			'id': attributes.id
			callback: (response) ->
				attributes.groups = response.data
				callback attributes

	parse: (attributes) ->
		attributes.title = attributes.username

		attributes

	beforeSave: (callback) ->
		attributes = _.extend {}, @attributes # copy @attributes

		delete attributes.groups
		delete attributes.title

		callback attributes

	afterSave: (callback) ->
		person_id = @id
		values = []
		sqlq = "DELETE FROM `group__person` WHERE `person_id` = '" + person_id + "'"
		
		db.run sqlq, (response) =>
			for group_id in _.pluck(@get('groups'), 'id')
				values.push "('"+group_id+"', '"+person_id+"')"

			if values.length > 0
				sqlq = "INSERT INTO `group__person` VALUES "
				sqlq = sqlq + values.join()

				db.run sqlq, (response) => callback @attributes
			else
				callback @attributes

module.exports = Person