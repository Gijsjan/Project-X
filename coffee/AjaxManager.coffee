define (require) ->
	Backbone = require 'backbone'
	ev = require 'EventDispatcher'
	
	# AjaxManager centralises ajax calls
	# Ajax calls are made using:
	# ev.trigger 'ajaxGET',
	#		'url': 'someurl'
	#		success: (data) -> @domydata(data)

	class AjaxManager

		constructor: ->
			@baseurl = '/b'

		options: (url, success) ->
			'url': @baseurl + url
			'dataType': 'json'
			success: (response) => success(response)
			error: (response) => ev.trigger response.status+''
				
		# GET calls are stored in the @calls variable (WHAT IF DATA CHANGES (UPDATE, DELETE))
		get: (args) ->
			[url, success] = [args.url, args.success]

			options = _.extend @options(url, success),
				'type': 'get'

			$.ajax options
				
		post: (args) ->
			[url, data, success] = [args.url, args.data, args.success]

			options = _.extend @options(url, success),
				'type': 'post'
				'data': data

			
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