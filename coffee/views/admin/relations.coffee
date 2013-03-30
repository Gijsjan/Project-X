define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/admin/relations.html'
	ajax = require 'AjaxManager'
	hlpr = require 'helper'

	class vAdminRelations extends BaseView

		'id': 'admin-relations'

		'events':
			'click #submit': 'onSubmit'
			'click ul.nav li a': 'getObject'
			'click ul.nav li a button': 'deleteObject'

		onSubmit: (e) ->
			bucket = @$('#bucket').val()
			key = @$('#key').val()
			value = @$('#value').val()

			if key isnt ''
				url = '/b/db/'+bucket+'/'+key
				type = 'PUT'
			else
				url = '/b/db/'+bucket
				type = 'POST'

			$.ajax
				'url': url
				'type': type
				'contentType': 'application/json; charset=UTF-8'
				'dataType': 'json'
				'data': value
				'success': (data) =>
					console.log data
					@updateView()
				'error': (response) =>
					console.log response

			false

		getObject: (e) ->
			key = e.currentTarget.dataset.key
			bucket = e.currentTarget.dataset.bucket

			ajax.get
				'url': '/db/'+bucket+'/'+key # +@$('#bucket').val()
				success: (data) =>
					@$('#bucket').val(bucket)
					@$('#key').val(key)
					@$('#value').val(JSON.stringify(data, null, 4))

			false

		deleteObject: (e) ->
			e.stopPropagation()
			key = e.currentTarget.dataset.key
			bucket = e.currentTarget.dataset.bucket

			ajax.delete
				'url': '/db/'+bucket+'/'+key # +@$('#bucket').val()
				success: (data) => @updateView()

			false
			
		
		initialize: ->
			@render()

			ajax.get
				'url': '/db/relations'
				success: (data) => @renderBucketList(data.keys)

		render: ->
			html = _.template tpl, 'lists': @lists

			@$el.html html

			@

		# renderPeople: ->
		# 	@$('ul#person').html ''
		# 	for person in @people
		# 		close = $('<button />').addClass('close').html('&times;').attr('data-key', person).attr('data-bucket', 'people')
		# 		a = $('<a />').attr('href', '#').attr('data-key', person).attr('data-bucket', 'people')
		# 		li = $('<li />').html(a.html(person).append(close))
		# 		@$('ul#person').append li

		# renderNotes: ->
		# 	@$('ul#note').html ''
		# 	for note in @notes
		# 		close = $('<button />').addClass('close').html('&times;').attr('data-key', note.id).attr('data-bucket', note.type)
		# 		a = $('<a />').attr('href', '#').attr('data-key', note.id).attr('data-bucket', note.type)
		# 		li = $('<li />').html(a.html(note.title).append(close))
		# 		@$('ul#note').append li

		renderBucketList: (list) ->
			console.log list
			@$('ul#relations').html ''
			for item in list
				close = $('<button />').addClass('close').html('&times;').attr('data-key', item).attr('data-bucket', 'relations')
				a = $('<a />').attr('href', '#').attr('data-key', item).attr('data-bucket', 'relations')
				li = $('<li />').html(a.html(item).append(close))
				@$('ul#relations').append li