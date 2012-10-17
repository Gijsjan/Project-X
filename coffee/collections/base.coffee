define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class BaseCollection extends Backbone.Collection
		
		url: ->
			dbview = @dbview.split '/'
			'/db/projectx/_design/'+dbview[0]+'/_view/'+dbview[1]

		initialize: (options) ->
			# console.log 'BaseCollection.initialize()'
			@dbview = if options? and options.dbview? then options.dbview else ''

		sync: (method, collection, options) ->
			# console.log 'BaseCollection.sync()'
			cachedResponse = @collectionManager.collections[@url()]

			if method is 'read' and cachedResponse?
				options.success(cachedResponse)
			else
				Backbone.sync(method, collection, options)

		# parse: (response) ->
		# 	# console.log 'BaseCollection.parse()'
		# 	@collectionManager.register @url(), response
		# 	response.rows

		parse: (response) ->
			console.log 'cContent.parse()'
			console.log response
			@collectionManager.register @url, response
			_.pluck(response.rows, 'value');