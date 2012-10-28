define (require) ->
	EditViews = require 'switchers/views.edit'
	FullViews = require 'switchers/views.full'
	Collections = require 'switchers/collections'
	Models = require 'switchers/models'
	mNote = require 'models/object/content/note'
	vNoteList = require 'views/object/content/note/list'
	vFullNote = require 'views/object/content/note/full'
	vEditNote = require 'views/object/content/note/edit'
	# vObjectListControl = require 'views/object/list.control'
	hlpr = require 'helper'

	class NotesRouter extends Backbone.Router

		routes:		
			"notes/new": "edit"
			"notes/:id/edit": "edit"
			"notes/:id": "show"
			"notes": "notelist" # DOESNT WORK WITH TRAILING SLASH?

		show: (id) ->
			# console.log 'NotesRouter.show()'

			data =
				'className': 'note full'
				'id': 'object '+id
				'model': new mNote
					'id': id

			full = new vFullNote data

			$('div#main').html full.$el

		edit: (id) ->
			# console.log 'ContentRouter -> edit()'
			# parent_type = hlpr.getParentType object_type # CHANGE THIS -> OBJECT/CONTENT/GROUP IS ALREADY GIVEN IN OBJECT_TYPE
			# data =
			# 	'className': 'note edit' # className cannot be dynamicly set in the view, only other options is using jQuery's addClass in the views initialize method
			# 	'model': new mNote()

			# if id? # id is defined when edit event is triggered, but not when the add event is triggered
			# 	data.model = new Models['content/'+object_type] id: id #override the default model with a model with an id
			# 	data.id = id
			model = if id? then new mNote('id': id) else new mNote()

			ev = new vEditNote 'model': model
			ev.on 'done', (model) ->
				# console.log 'ContentRouter.edit() ' + object_type + ' || EditView || saved!'
				@navigate model.get('bucket') + '/' + model.get('id'), true

			# USE VIEWMANAGER
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': ev

		notelist: (object_type) ->
			# console.log 'ContentRouter -> notelist()'
			v = new vNoteList()
			
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': v