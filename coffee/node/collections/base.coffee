_ = require 'underscore'
Backbone = require 'backbone'
db = require('../MySQLConnection')

class BaseCollection extends Backbone.Collection

	initialize: ->
		console.log 'BaseCollection.initialize: @model empty or unknown!' if _.isEmpty @model or not @model?
		console.log @model if _.isEmpty @model or not @model?
		
		m = new @model
		@type = m.type

	fetchOptions: ->
		'tables': @type

	fetch: (callback, options) ->
		options = @fetchOptions() if not options?
		console.log options

		super
			'fetchOptions': options
			success: (collection, response, options) => 
				callback
					'code': options.code
					'data': response
			error: (collection, xhr, options) => console.log xhr

	sync: (method, collection, options) ->
		[fetchOptions, success, error] = [options.fetchOptions, options.success, options.error]

		if method is 'read'
			fetchOptions.callback = (response) ->
				if response.code is 200
					options.code = response.code
					success collection, response.data, options
				else
					error collection, response, options

			db.select fetchOptions

module.exports = BaseCollection