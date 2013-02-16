define (require) ->
	BaseRouter = require 'routers/base'
	# EditViews = require 'switchers/views.edit'
	# FullViews = require 'switchers/views.full'
	# Collections = require 'switchers/collections'
	# Models = require 'switchers/models'
	ContentFull = require 'models/content.full'
	vNoteList = require 'views/content/note/list'
	vFullNote = require 'views/content/note/full'
	vEditNote = require 'views/content/note/edit'

	Switcher = require 'switchers/switcher'
	# vObjectListControl = require 'views/object/list.control'
	hlpr = require 'helper'

	class ContentRouter extends BaseRouter

		'type_ids':
			'note': '1'
			'document': '2'
			'todo': '3'

		'routes':		
			"content/:type/new": "edit"
			"content/:type/:id/edit": "edit"
			# "notes/mine": "listMyNotes" # DOESNT WORK WITH TRAILING SLASH?
			"content/:type/:id": "show"
			"content/:type": "list" # DOESNT WORK WITH TRAILING SLASH?

		show: (type, id) ->
			# console.log 'NotesRouter.show()'
			@breadcrumbs = 'Notes': '/content/note'
			@breadcrumbs[id] = ''

			@view = new Switcher.Views.Full[type] 'model': @_getModel type, id

		edit: (type, id) ->
			@breadcrumbs = 'Notes': '/content/note'
			@breadcrumbs[id] = '/note/'+id if id?
			@breadcrumbs.edit = ''

			@view = new Switcher.Views.Edit[type] 'model': @_getModel type, id
		
		list: (type) ->
			# console.log 'ContentRouter -> notelist()'
			@breadcrumbs = 'Notes': ''

			# @view = new Switcher.Views.List[type] 'model': @_getModel type
			@view = new vNoteList 'model': @_getModel type

		_getModel: (type, id) ->
			model = if id? then new Switcher.Models[type] 'id': id else new Switcher.Models[type]()
			model.set 'type',
				'id': @type_ids[type]
				'value': type

			model

		# listMyNotes: ->
		# 	# console.log 'ContentRouter -> notelist()'
		# 	@breadcrumbs =
		# 		'All Notes': '/notes' 
		# 		'My Notes': ''

		# 	@view = new vNoteList 'mine': true