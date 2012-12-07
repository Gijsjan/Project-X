define (require) ->
	BaseRouter = require 'routers/base'
	Organisation = require 'models/group/organisation'
	vFullOrganisation = require 'views/group/organisation/full'
	EditOrganisation = require 'views/group/organisation/edit'
	vOrganisationList = require 'views/group/organisation/list'

	class OrganisationsRouter extends BaseRouter

		'routes':
			"organisations/new": "edit"
			"organisations/:id/edit": "edit"
			"organisations/:id": "show"
			"organisations": "list"

		edit: (id) ->
			@breadcrumbs = 'Organisations': '/organisations'
			@breadcrumbs[id] = '/organisations/'+id if id?
			@breadcrumbs.edit = ''
			
			model = if id? then new Organisation('id': id) else new Organisation()

			@view = new EditOrganisation 'model': model

		show: (id) ->
			@breadcrumbs = 'Organisations': '/organisations'
			@breadcrumbs[id] = ''
			
			@view = new vFullOrganisation 'id': id

		list: ->
			@breadcrumbs = 'Organisations': ''
			
			@view = new vOrganisationList()