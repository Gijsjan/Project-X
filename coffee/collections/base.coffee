define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class BaseCollection extends Backbone.Collection
		
		sync: (method, collection, options) ->
			# console.log 'BaseCollection.sync()'
			cachedResponse = @collectionManager.collections[@url]

			if method is 'read' and cachedResponse?
				options.success(cachedResponse)
			else
				Backbone.sync(method, collection, options)
		
		parse: (response) ->
			# console.log 'BaseCollection.parse()'
			@collectionManager.register @url, response

			response = _.map response, (obj) =>
				obj.data.meta = obj.meta
				obj.data.id = obj.meta.key
				delete obj.meta
				@modelManager.register obj.data
				obj.data

			response
		# url: ->
		# 	dbview = @dbview.split '/'
		# 	'/db/projectx/_design/'+dbview[0]+'/_view/'+dbview[1]+'?include_docs=true'

		# initialize: (options) ->
		# 	# console.log 'BaseCollection.initialize()'
		# 	@dbview = if options? and options.dbview? then options.dbview else ''


		# parse: (response) ->
		# 	# console.log 'BaseCollection.parse()'
		# 	url = if typeof @url is 'function' then @url() else @url
		# 	@collectionManager.register url, response
		# 	_.pluck(response.rows, 'doc');