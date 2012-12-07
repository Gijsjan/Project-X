define (require) ->
	BaseRouter = require 'routers/base'
	# EditViews = require 'switchers/views.edit'
	# FullViews = require 'switchers/views.full'
	# Collections = require 'switchers/collections'
	# Models = require 'switchers/models'
	mNote = require 'models/content/note'
	vNoteList = require 'views/content/note/list'
	vFullNote = require 'views/content/note/full'
	vEditNote = require 'views/content/note/edit'
	# vObjectListControl = require 'views/object/list.control'
	hlpr = require 'helper'

	class NotesRouter extends BaseRouter

		'routes':		
			"notes/new": "edit"
			"notes/:id/edit": "edit"
			# "notes/mine": "listMyNotes" # DOESNT WORK WITH TRAILING SLASH?
			"notes/:id": "show"
			"notes": "list" # DOESNT WORK WITH TRAILING SLASH?

		show: (id) ->
			# console.log 'NotesRouter.show()'
			@breadcrumbs = 'Notes': '/notes'
			@breadcrumbs[id] = ''

			@view = new vFullNote 'id': id

		edit: (id) ->
			@breadcrumbs = 'Notes': '/notes'
			@breadcrumbs[id] = '/notes/'+id if id?
			@breadcrumbs.edit = ''

			model = if id? then new mNote('id': id) else new mNote()

			@view = new vEditNote 'model': model
		
		list: ->
			# console.log 'ContentRouter -> notelist()'
			@breadcrumbs = 'Notes': ''

			@view = new vNoteList()

		# listMyNotes: ->
		# 	# console.log 'ContentRouter -> notelist()'
		# 	@breadcrumbs =
		# 		'All Notes': '/notes' 
		# 		'My Notes': ''

		# 	@view = new vNoteList 'mine': true