_ = require 'underscore'
http = require 'http'

Models = require './switchers/models'
Collections = require './switchers/collections'
user = require './models/people/user'

db = require('./MySQLConnection')

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
	if req.url is '/db/login' or req.session.currentUser?
		next()
	else
		_writeResponse 'code': 401, res

app.param 'table', (req, res, next, id) ->
	tables =
		'group': {}
		'person': {}
		'note': {}
		'department': {}
		'organisation': {}

	if tables.hasOwnProperty(id)
		next()
	else
		_writeResponse 'code': 404, res

# arg: response => is an object with code (http) and data (model, collection or error) attributes.
_writeResponse = (response, res) ->
	console.log '_writeResponse: no http code!' if not response.code?
	response.data = {} if not response.data?

	res.writeHead response.code, 'Content-Type': 'application/json; charset=UTF-8'
	res.end JSON.stringify(response.data)


###########
### GET ###
###########

app.get '/db/authorize', (req, res) ->
	response =
		'code': 200
		'data': req.session.currentUser

	_writeResponse response, res

app.get '/db/:table/type', (req, res) ->
	db.select
		'tables': req.params.table+'_type'
		'fields': ['id', 'value']
		callback: (response) -> _writeResponse response, res

app.get '/db/:table/:id', (req, res) ->
	model = new Models[req.params.table] 'id': req.params.id
	model.fetch (response) -> _writeResponse response, res

app.get '/db/:table', (req, res) ->
	collection = new Collections[req.params.table]()
	collection.fetch (response) -> _writeResponse response, res

# app.get '/db/select/:table/by/group/:group_id', (req, res) ->
# 	collection = new Collections[req.params.table]()
# 	collection.fetch
# 		'selector': 
# 			'name': 'byGroup'
# 			'id': req.params.group_id
# 		callback: (response) -> 
# 			if not response.code
# 				response =
# 					'code': 200
# 					'data': response

# 			_writeResponse response, res

	# model = new Models[req.params.table]()
	# fields = _.keys model.attributes
	# fields.push model.title + ' as title'
	# fields.push 'id'

	# db.select
	# 	'tables': req.params.table
	# 	'fields': fields
	# 	callback: (response) -> _writeResponse response, res 


############
### POST ###
############

app.post '/db/login', (req, res) ->
	db.select
		'tables': 'person'
		'where': "`person`.`email` = '"+req.body.email+"' AND `person`.`password` = '"+req.body.password+"'"
		callback: (response) ->
			if response.data.length > 0
				response.data = response.data[0]
				person = new Models['person'] response.data
				req.session.currentUser = person.attributes
			else
				response = 'code': 401 # Unauthorized
			
			_writeResponse response, res

app.post '/db/logout', (req, res) ->
	req.session.currentUser = null
	_writeResponse 'code': 200, res

_saveOLD = (req, res) ->
	model = new Models[req.params.table] req.body
	model.save (value) -> _writeResponse value, res


_save = (req, res) ->
	content = new Models['content'] req.body
	content.save (response) ->
		if response.code is 200 or response.code is 201
			model = new Models[req.params.table] req.body
			model.id = response.data.id
			model.save (value) -> _writeResponse value, res
		else
			console.log 'Server._save error'
			console.log response
			_writeResponse response, res


app.post '/db/:table', _save
app.put '/db/:table/:key', _save


###########
### PUT ###
###########



##############
### DELETE ###
##############

app.delete '/db/:table/:id', (req, res) ->
	model = new Models[req.params.table] 'id': req.params.id
	model.destroy (response) -> _writeResponse response, res

app.listen 3000
console.log 'Node server running on :3000'