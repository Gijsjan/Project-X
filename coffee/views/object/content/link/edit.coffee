define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditContent = require 'views/object/content/edit'
	tpl = require 'text!html/link/edit.html'

	class vEditLink extends vEditContent
		events: _.extend({}, vEditContent.prototype.events, 
			"paste .address": "getPageContents"
			"change .possible_title_checkbox": "onLinkSelected"
			"click #submit_title": "onLinkSelected")

		initialize: ->
			@h1 = []
			@h2 = []

			super
		
		onLinkSelected: (e) ->
			selected_title = if not e.currentTarget.value then @$('#title').val() else e.currentTarget.value
			@model.set 'title', selected_title

			@render()
			# @$('#part1').hide()
			# @$('#part2').hide()
			# @$('#part3').show()
		
		getPageContents: (e) ->
			url = $(e.currentTarget).val()
			
			expression = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
			regex = new RegExp(expression)
				
			if url.match regex
				console.log 'match!'
				$.getJSON 'http://projectx/backend/getheadings/?url='+url, (response) => 
					@h1 = response.h1
					@h2 = response.h2

					@render()

					# @$('#part1').hide()
					# @$('#part2').show()
					# @$('#part3').hide()

			else
				console.log 'no match'
			###
			url = ''
			
			callback = =>
				url = $(e.currentTarget).val()
				
				if url.match regex
					$.post	'/api/upload_link.php',
							'url': url,
							(data) ->
								if data.id?
									@model.set(data) # move out of if?
									@render()
									@$('#part1').hide()
									@$('#part2').show()
									@$('#part3').hide()
								else
									@model.set(data)
									@render()
									@$('#part1').hide()
									@$('#part2').hide()
									@$('#part3').show()
							, "json"
				else
					alert "No match"

			setTimeout callback, 0
			###
		
		render: ->
			# console.log 'vEditFormat.render()'
			# super

			html = _.template tpl, 
				'link': @model.toJSON()
				'h1': @h1
				'h2': @h2

			@$el.html html

			# if not @model.get 'id'
			# 	@$('#part1').show()
			# else
			# 	@$('#part3').show()
			
			@