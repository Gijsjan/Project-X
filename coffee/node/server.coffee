_ = require('underscore')
db = require('riak-js').getClient()
express = require('express')
app = express()

app.use express.bodyParser()
app.use express.cookieParser('b3SSdon4M3SSw14h')
app.use express.cookieSession 'secret': 'D0ntm3ssw1ththeB3ss'

# app.use (req, res, next) ->
# 	# console.log req.body
# 	# if req.session.token
# 	# 	console.log req.session.token
# 	# else if req.body.email is 'agijsbro@gmail.com' and req.body.password is 'gijs'
# 	# 	req.session.token = 'this is a token'
# 	# else
# 	# 	writeResponse 401, res

# 	console.log req.session.cookie
# 	console.log req.cookies


app.param 'bucket', (req, res, next, id) ->
	buckets =
		'people': {}
		'notes': {}

	if buckets.hasOwnProperty(id)
		next()
	else
		writeResponse 404, res

app.get '/db/:bucket', (req, res) ->
	db.getAll req.params.bucket, (err, data, meta) ->
		writeResponse data, res

app.get '/db/:bucket/:id', (req, res) ->	
	db.get req.params.bucket, req.params.id, (err, data, meta) ->
		if (err) then writeResponse err.statusCode, res
		else
			data['id'] = req.params.id
			data['bucket'] = req.params.bucket
			writeResponse data, res

app.put '/db/:bucket/:id', (req, res) ->
	delete req.body.id # don't save the id and bucket
	delete req.body.bucket

	db.save req.params.bucket, req.params.id, req.body

	req.body['id'] = req.params.id
	req.body['bucket'] = req.params.bucket
	writeResponse req.body, res

app.post '/db/:bucket', (req, res) ->
	delete req.body.bucket

	db.save req.params.bucket, undefined, req.body, (err, result, meta) ->
		req.body['id'] = meta.key
		req.body['bucket'] = req.params.bucket
		writeResponse req.body, res

app.post '/db/authorize', (req, res) ->
	db.get 'people', req.body.email
	writeResponse req.body, res

app.delete '/db/:bucket/:id', (req, res) ->
	db.remove req.params.bucket, req.params.id

	writeResponse 204, res

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