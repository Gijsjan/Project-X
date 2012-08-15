define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditContent = require 'views/object/content/edit'

	vEditContent.extend
		events: _.extend({}, vEditContent.prototype.events, 'change .upload': 'onDocumentSelected')
		onDocumentSelected: (e) ->
			file = document.getElementById('pdf-file').files[0]
			xhr = new XMLHttpRequest()
			updateProgressbar = (e) =>
				@$('#progressbar').attr 'value', e.loaded/e.total * 100
				return
			xhr.upload.addEventListener 'loadstart', @showPart2, false
			xhr.upload.addEventListener 'progress', updateProgressbar(e), false
			xhr.upload.addEventListener 'load', @onLoad, false
			xhr.open 'POST', '/api/upload_document.php', true
			xhr.setRequestHeader 'Content-type', file.type
			xhr.setRequestHeader 'X_FILE_NAME', file.name
			xhr.setRequestHeader 'X_FILE_SIZE', file.size
			xhr.send file
			xhr.onreadystatechange = =>
				if xhr.readyState is 4
					if xhr.status is 200
						response = JSON.parse xhr.responseText
						@model.set response
						@render()
						@showPart3
						return
		initialize: ->
			vEditContent.prototype.initialize.apply @
		render: ->
			vEditContent.prototype.render.apply @

			if @model.get('id')?
				@showPart3()
			else
				@showPart1()

			@
		showPart1: =>
			@$('#part1').show()
			@$('#part2').hide()
			@$('#part3').hide()
			return
		showPart2: =>
			@$('#part1').hide()
			@$('#part2').show()
			@$('#part3').hide()
			return
		showPart3: =>
			@$('#part1').hide()
			@$('#part2').hide()
			@$('#part3').show()
			return