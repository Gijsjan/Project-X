define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	
	class AjaxManager		
		calls: {}

		baseurl: '/db/projectx/'

		constructor: (globalEvents) ->
			globalEvents.on 'ajaxGet', @get, @
			globalEvents.on 'ajaxPut', @put, @

		post: (options) ->

		get: (options) ->
			if @calls.hasOwnProperty(options.url)
				options.success @calls[options.url]
			else
				$.ajax
					'url': @baseurl + options.url
					'dataType': 'json'
					'success': (data) =>
						@calls[options.url] = data
						options.success(data)
					'error': (response) =>
						@navigate 'login' if response.status is 401

		put: (options) ->
			$.ajax
				'url': @baseurl + options.url
				'type': 'put'
				'dataType': 'json'
				'success': (data) =>
					options.success(data)
				'error': (response) =>
					@navigate 'login' if response.status is 401


		# register: (model) ->
		# 	if _.isArray(model)
		# 		model.forEach((m) => @models[m.get('id')] = m if m.get('id')?)
		# 	else
		# 		@models[model.get('id')] = model if model.get('id')?