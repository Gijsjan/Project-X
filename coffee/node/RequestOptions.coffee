_ = require 'underscore'

class RequestOptions

	'defaults':
		'host': 'projectx'
		'port': 8098
		'method': 'GET'		

	constructor: (args = {}) ->
		[bucket, key] = [args.bucket, args.key]

		@options = {}
		@options.path = '/buckets/'+bucket+'/keys/'+key if bucket? and key? # Set the default path
		@options.headers = 'Content-Type': 'application/json'

	# Get all options
	get: ->
		_.extend({}, @defaults, @options)

	# Set one option
	set: (key, value) ->
		option = {}
		option[key] = value

		_.extend(@options, option)

	# addHeader: (key, value) ->
	# 	header = {}
	# 	header[key] = value

module.exports = RequestOptions