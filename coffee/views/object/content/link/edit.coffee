define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditContent = require 'views/object/content/edit'

	vEditContent.extend
		events: _.extend({}, vEditContent.prototype.events, 
			"paste .address": "getPageContents"
			"change .possible_title_checkbox": "onLinkSelected"
			"click #submit_title": "onLinkSelected")
		
		onLinkSelected: (e) ->
			selected_title = if not e.currentTarget.value then @$('#title').val() else e.currentTarget.value
			@model.set 'title', selected_title

			@render()
			@$('#part1').hide()
			@$('#part2').hide()
			@$('#part3').show()
		
		getPageContents: (e) ->
			expression = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi
			regex = new RegExp(expression)
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
		
		render: ->
			vEditContent.prototype.render.apply @

			if not @model.get 'id'
				@$('#part1').show()
			else
				@$('#part3').show()

			@