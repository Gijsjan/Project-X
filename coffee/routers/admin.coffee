define (require) ->
	BaseRouter = require 'routers/base'
	vAdminHome = require 'views/admin/home'
	vAdminRelations = require 'views/admin/relations'

	class AdminRouter extends BaseRouter
		
		routes:
			'admin': 'home'
			'admin/relations': 'relations'

		home: ->
			@breadcrumbs = 'Admin': ''
			@view = new vAdminHome()

		relations: ->
			@breadcrumbs = 'Admin': '/admin'
			@breadcrumbs['Relations'] = ''

			@view = new vAdminRelations()