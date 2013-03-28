define (require) ->
	BaseRouter = require 'routers/base'
	Full = require 'views/group/full'
	Edit = require 'views/group/edit'


	class MainRouter extends BaseRouter

		'routes':
			'': 'home'
			":type/new": "edit"
			":type/:id/edit": "edit"
			":type/:id": "show"
			'404': 'notfound'

		initialize: (options) ->
			@route ':type', 'list', (type) =>
				switch type
					when 'people'
						@list 'person'
					when 'groups'
						@list 'group'
					else
						@notfound()

			super

		home: ->
			$('div#main').html ''

		show: (type, id) ->
			@breadcrumbs[type] = '/'+type
			@breadcrumbs[id] = ''
			
			@view = new Full[type] 'id': id

		edit: (type, id) ->
			@breadcrumbs[type] = '/'+type
			
			if id?
				@breadcrumbs[id] = '/'+type+'/'+id
				@breadcrumbs.edit = ''
			else 
				@breadcrumbs.new = ''

			@view = new Edit[type] 'model': @_getModel(type, id)

		notfound: ->
			@breadcrumbs = 'Not found': ''

			$('div#main').html 'not found!' # CHANGE TO VIEW