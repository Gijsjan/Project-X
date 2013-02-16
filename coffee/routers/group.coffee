define (require) ->
	BaseRouter = require 'routers/base'
	Group = require 'models/group.full'
	vFullGroup = require 'views/group/full'
	vEditGroup = require 'views/group/edit'
	vList = require 'views/list'

	class GroupRouter extends BaseRouter

		'routes':
			"group/new": "edit"
			"group/:id/edit": "edit"
			"group/:id": "show"
			"groups": "list"

		edit: (id) ->
			@breadcrumbs = 'Groups': '/groups'
			@breadcrumbs[id] = '/group/'+id if id?
			@breadcrumbs.edit = ''
			
			model = if id? then new Group('id': id) else new Group()

			@view = new vEditGroup 'model': model

		show: (id) ->
			@breadcrumbs = 'Groups': '/groups'
			@breadcrumbs[id] = ''
			
			@view = new vFullGroup 'id': id

		list: ->
			@breadcrumbs = 'Group': ''
			
			@view = new vList 'type': 'group'