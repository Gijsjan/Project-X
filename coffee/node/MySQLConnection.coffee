_ = require 'lodash'
mysql = require 'mysql'
Backbone = require 'backbone'

class MySQLConnection

	constructor: ->
		@connect()

		_.extend @, Backbone.Events

	connect: ->
		if not @connection?
			@connection = mysql.createConnection
				'host': 'localhost'
				'user': 'root'
				'password': 'sql77338'
				'database': 'projectx'


	select: (args, cb) ->
		args.fields = ['*'] if not args.fields?
		args.tables = [args.tables] if _.isString args.tables
		args.fields = [args.fields] if _.isString args.fields

		tables = '`'+args.tables.join('`, `')+'`'

		sqlq = "SELECT " + args.fields.join() + " FROM " + tables
		sqlq += ' WHERE '+args.where if args.where?
		# console.log sqlq
		@connection.query sqlq, (err, rows, fields) =>
			response = {}

			if not err?
				response.code = 200
				response.data = rows
			else
				response.code = @_getErrorCode err

			cb response



	save: (table, attributes, callback) ->
		fields = ''
		values = ''
		update = ''
		response = {}

		for key in _.keys(attributes)
			fields += "`"+key+"`,"
		fields = fields.slice(0,-1) 

		for value in _.values(attributes)
			values += "'"+value+"',"
		values = values.slice(0,-1)

		for own key, value of attributes
			update += "`"+key+"` = '"+value+"',"
		update = update.slice(0,-1) 
		sqlq = "INSERT INTO `"+table+"` ("+fields+") 
				VALUES ("+values+") 
				ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), "+update
		console.log sqlq		
		@connection.query sqlq, (err, rows, fields) =>
			if not err?
				response.code = if attributes.id? then 200 else 201
				response.data = rows.insertId if rows.insertId
			else
				response.code = @_getErrorCode err

			callback response

	destroy: (table, id, callback) ->
		sqlq = "DELETE FROM `"+table+"` WHERE `id` = '"+id+"'"
		@run sqlq, callback


	run: (sqlq, callback) ->
		@connection.query sqlq, (err, rows, fields) =>
			response = {}
			response.code = if not err? then 200 else @_getErrorCode err

			callback response if callback?

	_getErrorCode: (err) ->
		console.log err

		switch err.code 
			when 'ER_BAD_FIELD_ERROR' then code = 400
			when 'ER_NO_SUCH_TABLE' then code = 400
			when 'ER_DUP_ENTRY' then code = 409
			when 'ER_ROW_IS_REFERENCED_' then code = 409
			when 'ER_PARSE_ERROR' then code = 500
			else code = 400

		code
 

module.exports = new MySQLConnection()



	# get: (table, id) ->
	# 	console.log 'get'

	# getAll: (table, fieldArray, callback) ->
	# 	response = {}
		
	# 	if _.isFunction fieldArray
	# 		callback = fieldArray
	# 		fieldArray = ['*'] 

	# 	sqlq = "SELECT "+fieldArray.join()+" FROM `"+table+"`"

	# 	@connection.query sqlq, (err, rows, fields) =>
	# 		if not err?
	# 			response.code = 200
	# 			response.data = rows
	# 		else
	# 			response.code = @_getErrorCode err.code

	# 		callback response

	# update: (table, attributes, callback) ->
	# 	data = ''
	# 	response = {}

	# 	for own key, value of attributes
	# 		data += "`"+key+"` = '"+value+"',"
	# 	data = data.slice(0,-1) 

	# 	sqlq = "UPDATE `"+table+"` SET "+data+" WHERE `"+table+"`.`id` = "+attributes.id

	# 	@connection.query sqlq, (err, rows, fields) =>
	# 		if not err?
	# 			response.code = 200
	# 			@trigger 'afterUpdate'
	# 		else
	# 			response.code = @_getErrorCode err

	# 		callback response