define (require) ->
	BaseRouter = require 'routers/base'
	ContentFull = require 'models/content.full'
	vFullNote = require 'views/content/note/full'
	vEditNote = require 'views/content/note/edit'
	Switcher = require 'switchers/switcher'

	class ContentRouter extends BaseRouter

		'routes':		
			"content/:type/new": "edit"
			"content/:type/:id/edit": "edit"
			"content/:type/:id": "show"
			"content/:type": "list" # DOESNT WORK WITH TRAILING SLASH?

		show: (type, id) ->
			@breadcrumbs[type] = '/content/'+type
			@breadcrumbs[id] = ''

			@view = new Switcher.Views.Full[type] 'model': @_getModel type, id

		edit: (type, id) ->
			@breadcrumbs[type] = '/content/'+type
			@breadcrumbs[id] = '/content/'+type+'/'+id if id?
			@breadcrumbs['edit'] = ''

			@view = new Switcher.Views.Edit[type] 'model': @_getModel type, id