define (require) ->
	Backbone = require 'backbone'
	ev = require 'EventDispatcher'

	class AjaxManager

		constructor: ->
			@baseurl = '/b'

		options: ->
			'dataType': 'json'
			success: (response) => success(response)
			error: (response) => ev.trigger response.status+''
				
		# GET calls are stored in the @calls variable (WHAT IF DATA CHANGES (UPDATE, DELETE))
		get: (options) ->
			options.type = 'get'
			options.url = @baseurl + options.url

			options = _.extend @options(), options
			
			$.ajax options
				
		post: (data, options) ->
			options.type = 'post'
			options.url = @baseurl + options.url
			options.data = data

			options = _.extend @options(), options

			$.ajax options

		put: (args) ->
			[url, data, success] = [args.url, args.data, args.success]

			options = _.extend @options(url, success),
				'type': 'put'
				'data': data

			$.ajax options
		
		delete: (args) ->
			[url, success] = [args.url, args.success]
			
			options = _.extend @options(url, success),
				'type': 'delete'

			$.ajax options

	new AjaxManager()