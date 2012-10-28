define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/admin/home.html'
	hlpr = require 'helper'

	class vAdminHome extends BaseView

		events:
			'click #submit': 'onSubmit'
			'click ul.nav li a': 'getObject'
			'click ul.nav li a button': 'deleteObject'

		onSubmit: (e) ->
			bucket = @$('#bucket').val()
			key = @$('#key').val()
			value = @$('#value').val()

			if key isnt ''
				url = 'http://projectx/riak/buckets/'+bucket+'/keys/'+key
				type = 'PUT'
			else
				url = 'http://projectx/riak/buckets/'+bucket+'/keys'
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
			$.ajax
				'url': 'http://projectx/riak/buckets/'+bucket+'/keys/'+key # +@$('#bucket').val()
				'type': 'GET'
				'contentType': 'application/json; charset=UTF-8'
				'dataType': 'json'
				'success': (data) =>
					@$('#bucket').val(bucket)
					@$('#key').val(key)
					@$('#value').val(JSON.stringify(data))
				'error': (response, status, error) =>
					console.log response
					console.log status
					console.log error

			false

		deleteObject: (e) ->
			e.stopPropagation()
			key = e.currentTarget.dataset.key
			bucket = e.currentTarget.dataset.bucket

			$.ajax
				'url': 'http://projectx/riak/buckets/'+bucket+'/keys/'+key # +@$('#bucket').val()
				'type': 'DELETE'
				'contentType': 'application/json; charset=UTF-8'
				'dataType': 'json'
				'success': (data) =>
					console.log data
					@updateView()
				'error': (response) =>
					console.log response

			false

		updateView: ->
			@getPeople()
			@getNotes()

		getPeople: ->
			$.ajax
				'url': 'http://projectx/b/db/people' # +@$('#bucket').val()
				'type': 'GET'
				'contentType': 'application/json; charset=UTF-8'
				'dataType': 'json'
				'success': (data) =>
					# @people = data
					# @renderPeople()
					@renderBucketList('person', data)
				'error': (response) =>
					console.log response

		getNotes: ->
			$.ajax
				# 'url': 'http://projectx/riak/buckets/notes/keys?keys=true' # +@$('#bucket').val()
				'url': 'http://projectx/b/db/notes' # +@$('#bucket').val()
				'type': 'GET'
				'contentType': 'application/json; charset=UTF-8'
				'dataType': 'json'
				'success': (data) =>
					# @notes = data
					# @renderNotes()
					@renderBucketList('note', data)
				'error': (response) =>
					console.log response
		
		initialize: ->
			@render()

		render: ->
			html = _.template tpl

			@$el.html html

			@updateView()

			@

		renderPeople: ->
			@$('ul#person').html ''
			for person in @people
				close = $('<button />').addClass('close').html('&times;').attr('data-key', person).attr('data-bucket', 'people')
				a = $('<a />').attr('href', '#').attr('data-key', person).attr('data-bucket', 'people')
				li = $('<li />').html(a.html(person).append(close))
				@$('ul#person').append li

		renderNotes: ->
			@$('ul#note').html ''
			for note in @notes
				close = $('<button />').addClass('close').html('&times;').attr('data-key', note.meta.key).attr('data-bucket', note.meta.bucket)
				a = $('<a />').attr('href', '#').attr('data-key', note.meta.key).attr('data-bucket', note.meta.bucket)
				li = $('<li />').html(a.html(note.data.title).append(close))
				@$('ul#note').append li

		renderBucketList: (id, list) ->
			@$('ul#'+id).html ''
			for item in list
				close = $('<button />').addClass('close').html('&times;').attr('data-key', item.meta.key).attr('data-bucket', item.meta.bucket)
				a = $('<a />').attr('href', '#').attr('data-key', item.meta.key).attr('data-bucket', item.meta.bucket)
				li = $('<li />').html(a.html(item.data.title).append(close))
				@$('ul#'+id).append li