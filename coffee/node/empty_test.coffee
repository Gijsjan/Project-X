_ = require('underscore')
http = require('http')
riak = require('./riak')
db = require('riak-js').getClient()

getEm = ->
	db.getAll 'test', (err, data, meta) ->
		i = 0

		removem = ->
			db.remove 'test', data[i].data.id, ->
				console.log 'deleted '+i
				i = i + 1
				removem()
						
		if not data[0]?
			console.log 'getEm'
			db.count 'test'
			return getEm()
		else
			removem()

db.count 'test', (err, c) ->
	console.log c
	getEm()

		# console.log data[i].data.id if data[i]?
		# db.remove 'test', data[i].data.id
		# if data?
		# 	console.log data.length
		# 	if data[i].id?
		# 		db.remove 'test', data[i].id
		# 	else if data[i].data.id?
		# 		db.remove 'test', data[i].data.id
		# 	else
		# 		console.log data[i]
		# 		return 0
		# else
		# 	console.log data
		# 	return 0