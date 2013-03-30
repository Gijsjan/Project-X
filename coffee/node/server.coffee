_ = require 'lodash'
http = require 'http'
async = require 'async'

Models = require './switchers/models'
Collections = require './switchers/collections'
user = require './models/people/user'

db = require('./MySQLConnection')

express = require('express')
RedisStore = require('connect-redis')(express)
sessionStore = new RedisStore()
app = express()

process.on 'uncaughtException', (err) ->
  console.log 'Caught exception: ' + err

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
		'carpool': {}

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
	fetchOptions = 
		'tables': req.params.table+'_type'
		'fields': ['id', 'value']

	db.select fetchOptions, (response) -> _writeResponse response, res

app.get '/db/:table/:id', (req, res) ->
	Models.get(req.params.table, req.params.id).attributes
	Models.get(req.params.table, req.params.id).fetch (response) ->
		_writeResponse response, res

app.get '/db/:table', (req, res) ->
	Collections.get(req.params.table).fetch (response) ->
		_writeResponse response, res

############
### POST ###
############

app.post '/db/login', (req, res) ->
	fetchOptions =
		'tables': 'person'
		'where': "`person`.`email` = '"+req.body.email+"' AND `person`.`password` = '"+req.body.password+"'"
	
	db.select fetchOptions, (response) ->
			if response.data.length > 0
				response.data = response.data[0] # do not remove, the response is returned 4 lines later
				req.session.currentUser = Models.get('person', response.data).attributes
			else
				response = 'code': 401 # Unauthorized
			
			_writeResponse response, res

app.post '/db/logout', (req, res) ->
	req.session.currentUser = null
	_writeResponse 'code': 200, res

_save = (req, res) ->
	if Models.get(req.params.table).isContent()
		async.waterfall [
			(callback) ->
				Models.get('content', req.body).save (response) -> 
					callback null, response
			(response, callback) ->
				Models.get(req.params.table, response.data).save (response) -> 
					callback null, response
			], 
			(err, result) -> _writeResponse result, res
	else
		Models.get(req.params.table, req.body).save (response) -> 
			_writeResponse response, res

app.post '/db/:table', _save
app.put '/db/:table/:key', _save

# _saveOLD = (req, res) ->
# 	model = new Models[req.params.table] req.body
# 	model.save (value) -> _writeResponse value, res


# _saveOLD2 = (req, res) ->
# 	content = new Models['content'] req.body
# 	content.save (response) ->
# 		if response.code is 200 or response.code is 201
# 			model = new Models[req.params.table] response.data
# 			model.save (value) -> _writeResponse value, res
# 		else
# 			console.log 'Server._save error'
# 			console.log response
# 			_writeResponse response, res



###########
### PUT ###
###########



##############
### DELETE ###
##############

app.delete '/db/:table/:id', (req, res) ->
	Models.get(req.params.table, req.params.id).destroy (response) -> 
		_writeResponse response, res

app.listen 3000
console.log 'Node server running on :3000'