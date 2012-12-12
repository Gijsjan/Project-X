_ = require 'underscore'
http = require 'http'
RequestOptions = require('./RequestOptions')

class Riak

	constructor: ->
		@currentUser = ''

	# private
	readData: (requestOptions, success, mapred) ->
		if mapred?
			requestOptions.set 'path', '/mapred'
			requestOptions.set 'method', 'POST'

		req = http.request requestOptions.get(), (res) ->
			data = ''
			res.setEncoding 'utf8'
			res.on 'data', (chunk) -> data += chunk
			res.on 'end', ->
				if res.statusCode is 200
					data = JSON.parse(data)
					success data, res.req.path if success?
				else
					success res.statusCode, res.req.path if success?
		req.on 'error', (e) -> console.log e
		req.write JSON.stringify(mapred) if mapred?
		req.end()

	write: (args) ->
		[bucket, key, data, success] = [args.bucket, args.key, args.data, args.success]

		args =
			'bucket': bucket
			'key': key

		reqOps = new RequestOptions args
		reqOps.set 'method', 'PUT'

		req = http.request reqOps.get(), (res) ->
			res.on 'end', -> success data if success?
		req.write JSON.stringify(data)

		req.on 'error', (e) -> console.log e
		req.end()

	read: (args) ->
		[bucket, key, success] = [args.bucket, args.key, args.success]

		reqOps = new RequestOptions
			'bucket': bucket
			'key': key

		req = http.request reqOps.get(), (res) ->
			data = ''
			res.setEncoding 'utf8'
			res.on 'data', (chunk) -> data += chunk
			res.on 'end', ->
				if res.statusCode is 200
					data = JSON.parse(data)
					success data if success?
				else
					success res.statusCode if success?
		req.on 'error', (e) -> console.log e
		req.end()

	readAll: (args) ->
		[bucket, success] = [args.bucket, args.success]

		console.log 'Riak.readAll is SLOW!'

		mapred = 
			'inputs': bucket
			'query': [
				'map':
					'language': 'javascript'
					'source': 'function(value, keyData, arg) { var obj = {}; var data = Riak.mapValuesJson(value)[0]; obj.id = data.id; obj.title = data.title; return [obj]; }'
					'keep': true]

		@readData(new RequestOptions(), success, mapred)

	readAllRelations: (args) ->
		[success] = [args.success]

		console.log 'Riak.readAllRelations is SLOW!'

		reqOps = new RequestOptions()
		reqOps.set 'path', '/buckets/relations/keys?keys=true'

		req = http.request reqOps.get(), (res) ->
			data = ''
			res.setEncoding 'utf8'
			res.on 'data', (chunk) -> data += chunk
			res.on 'end', ->
				if res.statusCode is 200
					data = JSON.parse(data)
					success data if success?
				else
					success res.statusCode if success?
		req.on 'error', (e) -> console.log e
		req.end()


	remove: (args) ->
		[bucket, key, success] = [args.bucket, args.key, args.success]

		requestOptions = new RequestOptions
			'bucket': bucket
			'key': key
		requestOptions.set 'method', 'DELETE'

		req = http.request requestOptions.get(), (res) ->
			res.on 'end', -> success res.statusCode
		req.on 'error', (e) -> console.log e
		req.end()

	filterByKey: (args) ->
		[bucket, func, value, success] = [args.bucket, args.func, args.value, args.success]

		mapred = 
			'inputs':
				'bucket': bucket
				'key_filters': [[func, value]]
			'query': [
				'map':
					'language': 'javascript'
					'source': 'function(value, keyData, arg) { var data = Riak.mapValuesJson(value)[0]; return [data]; }'
					'keep': true]

		@readData(new RequestOptions(), success, mapred)

	filterByIndex: (args) ->
		[bucket, index, value, success] = [args.bucket, args.index, args.value, args.success]

		mapred = 
			'inputs':
				'bucket': bucket
				'index': index+'_bin'
				'key': value
			'query': [
				'map':
					'language': 'javascript'
					'source': 'function(value, keyData, arg) { var data = Riak.mapValuesJson(value)[0]; return [data]; }'
					'keep': true]

		@readData(new RequestOptions(), success, mapred)



module.exports = new Riak()