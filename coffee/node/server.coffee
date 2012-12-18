_ = require 'underscore'
http = require 'http'

Models = require './switchers/models'
user = require './models/people/user'

riak = require './riak'
relationManager = require './RelationManager'
CallbackQueue = require './CallbackQueue'

express = require('express')
RedisStore = require('connect-redis')(express)
sessionStore = new RedisStore()
app = express()

app.use express.bodyParser()
app.use express.cookieParser('b3SSdon4M3SSw14h')
app.use express.cookieSession 
	'secret': 'D0ntm3ssw1ththeB3ss'
	'store': sessionStore
	'cookie':
		'maxAge': 60 * 60 * 1000 # 60 minutes
app.use (req, res, next) ->
	if req.url is '/db/login'
		next()
	else if req.session.currentUser?
		user.set req.session.currentUser
		next()
	else
		writeResponse 401, res

app.param 'bucket', (req, res, next, id) ->
	buckets =
		'people': {}
		'notes': {}
		'departments': {}
		'organisations': {}

	if buckets.hasOwnProperty(id)
		next()
	else
		writeResponse 404, res

### GET ###

# app.get '/db/test/getfromgijs', (req, res) ->
# 	riak.getfromgijs (data) -> writeResponse data, res

app.get '/db/authorize', (req, res) ->
	riak.read
		'bucket': 'people'
		'key': req.session.currentUser.id
		success: (data) ->
			data = 401 if _.isNumber(data) and data isnt 200
			writeResponse data, res

# getRelations = (data, success) ->
# 	if not _.isEmpty data.relations
# 		for own relation, value of data.relations
# 			riak.read
# 				'bucket': 'relations'
# 				'key': data.id+'|'+relation
# 				success: (response) ->
# 					data.relations[relation] = response
# 					success data

# app.get '/db/:bucket/:key/relations', (req, res) ->
# 	relationManager.get
# 		'groupBucket': req.params.bucket
# 		'groupKey': req.params.key
# 		success: (relations) -> writeResponse relations, res

app.get '/db/relations/:key', (req, res) ->
	riak.read
		'bucket': 'relations'
		'key': req.params.key
		success: (data) -> writeResponse data, res

app.get '/db/:bucket/:key', (req, res) ->
	relationManager.get
		'groupBucket': req.params.bucket
		'groupKey': req.params.key
		success: (relations) ->
			riak.read
				'bucket': req.params.bucket
				'key': req.params.key
				success: (data) -> 
					data.relations = relations
					writeResponse data, res

	# db.get 'people', req.body.email
	# writeResponse req.body, res

app.get '/db/relations', (req, res) ->
	riak.readAllRelations
		success: (data) -> writeResponse data, res

app.get '/db/:bucket', (req, res) ->
	riak.readAll
		'bucket': req.params.bucket
		success: (data) -> writeResponse data, res

# app.get '/db/:bucket/mine', (req, res) ->
# 	riak.filterByIndex req.params.bucket, 'owner', req.session.currentUser, (data) -> writeResponse data, res

# app.get '/db/bucket/:bucket/value/:value', (req, res) ->
# 	riak.filterByKey
# 		'bucket': req.params.bucket
# 		'func': 'starts_with'
# 		'value': req.params.value
# 		success: (data) -> writeResponse data, res

# app.get '/db/bucket/:bucket/index/:index/value/:value', (req, res) ->
# 	riak.filterByIndex req.params.bucket, req.params.index, req.params.value, (data) -> writeResponse data, res

### POST ###

#LOGIN
app.post '/db/login', (req, res) ->
	riak.filterByIndex
		'bucket': 'people'
		'index': 'email'
		'value': req.body.email
		success: (people) ->
			person = new Models['people'] people[0] # email is unique, so only one person should be found and returned

			if person.id? and person.get('password') is req.body.password
				req.session.currentUser = person.getRelationAttributes()
				writeResponse person, res
			else
				writeResponse 401, res

#LOGOUT
app.post '/db/logout', (req, res) ->
	req.session.currentUser = null
	writeResponse 200, res

# extendData = (req, res, next) ->
# 	req.body.created = new Date()
# 	if req.params.bucket is 'notes'
# 		req.body.owner = req.session.currentUser
# 	next()

	# if not _.isEmpty req.body.relations
	# 	for own relation, data of req.body.relations
	# 		riak.update
	# 			'bucket': 'relations'
	# 			'key': req.body.id+'|'+relation
	# 			'data': data
	# 			success: (response) ->
	# 				req.body.relations[relation] = true

#CREATE
app.post '/db/:bucket', (req, res) ->
	model = new Models[req.params.bucket] req.body	
	model.save (value) -> writeResponse value, res


### PUT ###

#UPDATE

# app.put '/db/relations', (req, res) ->

app.put '/db/:bucket/:key', (req, res) ->
	# queue = new CallbackQueue 2, (args) ->
	# 	[model, relations] = [args.model, args.relations]
	# 	model.relations = relations
	# 	writeResponse model, res

	model = new Models[req.params.bucket] req.body
	model.save (response) -> writeResponse response, res
	
	# relationManager.set
	# 	'groupModel': model
	# 	'relations': req.body.relations
	# 	success: queue.register('relations')
	# riak.update 
	# 	'bucket': req.params.bucket
	# 	'key': req.params.key
	# 	'data': req.body
	# 	success: (response) -> writeResponse response, res


	# delete req.body.bucket

	# db.save req.params.bucket, undefined, req.body, (err, result, meta) ->
	# 	req.body['id'] = meta.key
	# 	req.body['bucket'] = req.params.bucket
	# 	writeResponse req.body, res

### DELETE ###

app.delete '/db/:bucket/:key', (req, res) ->
	relationManager.destroy
		'modelData': req.body.modelData

	riak.remove
		'bucket': @get('type')
		'key': @get('id')
		success: (statusCode) -> writeResponse statusCode, res

	# req.body['id'] = req.params.id
	# req.body['bucket'] = req.params.bucket
	# writeResponse req.body, res

writeResponse = (data, res) ->
	if _.isNumber(data)
		code = data
		data = 'OK' if code is 200
		data = 'No Content' if code is 204
		data = 'Unauthorized' if code is 401
		data = 'Not Found' if code is 404
		data = '{"response": "'+data+'"}'
	else
		code = 200
		data = JSON.stringify(data)

	res.writeHead code, 'Content-Type': 'application/json; charset=UTF-8'
	res.end data

app.listen 3000
console.log 'Node server running on :3000'


# http = require 'http'
# url = require 'url'
# jsdom = require 'jsdom'
# db = require('riak-js').getClient()

# http.createServer( (request, response) ->
# 	urlparts = url.parse request.url, true
# 	path = urlparts.pathname
# 	console.log path

# 	if path is '//getheadings/'
# 		jsdom.env urlparts.query.url, ['http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js'], (errors, window) ->
# 			$ = window.$
			
# 			h1 = $.map($('h1'), (h1, i) -> $(h1).text().replace(/\s+/g, " ").trim())
# 			h2 = $.map($('h2'), (h2, i) -> $(h2).text().replace(/\s+/g, " ").trim())
			
# 			response.writeHead 200, 'Content-Type': 'application/json'
# 			response.end JSON.stringify('h1': h1, 'h2': h2)
# 	else if path is '//db/notes'
# 		db.getAll 'notes', (err, data) ->
# 			response.writeHead 200, 'Content-Type': 'application/json'
# 			response.end JSON.stringify(data)
# 	else if path is '//db/people'
# 		db.getAll 'people', (err, data) ->
# 			response.writeHead 200, 'Content-Type': 'application/json'
# 			response.end JSON.stringify(data)
# 	else
# 		response.writeHead 404, 'Content-Type': 'text/html'
# 		response.end 'not found'
# ).listen(3000, '127.0.0.1')

# console.log 'Server running at http://127.0.0.1:3000/'