define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/admin/home.html'
	ajax = require 'AjaxManager'
	hlpr = require 'helper'

	class vAdminHome extends BaseView

		'id': 'admin'

		'lists': [
			'people'
			'notes'
			'departments'
			'organisations'
		]

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

		updateView: ->
			for list in @lists
				@getList(list)

		getList: (type) ->
			ajax.get
				'url': '/db/'+type
				success: (data) => @renderBucketList(type, data)
		
		initialize: ->
			@render()

		render: ->
			html = _.template tpl, 'lists': @lists

			@$el.html html

			@updateView()

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

		renderBucketList: (id, list) ->
			@$('ul#'+id).html ''
			for item in list
				close = $('<button />').addClass('close').html('&times;').attr('data-key', item.id).attr('data-bucket', id)
				a = $('<a />').attr('href', '#').attr('data-key', item.id).attr('data-bucket', id)
				li = $('<li />').html(a.html(item.title).append(close))
				@$('ul#'+id).append li