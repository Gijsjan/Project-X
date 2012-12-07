define (require) ->
	BaseRouter = require 'routers/base'
	mDepartment = require 'models/group/department'
	vFullDepartment = require 'views/group/department/full'
	vEditDepartment = require 'views/group/department/edit'
	vDepartmentList = require 'views/group/department/list'

	class DepartmentsRouter extends BaseRouter

		'routes':
			"departments/new": "edit"
			"departments/:id/edit": "edit"
			"departments/:id": "show"
			"departments": "list"

		edit: (id) ->
			@breadcrumbs = 'Departments': '/departments'
			@breadcrumbs[id] = '/departments/'+id if id?
			@breadcrumbs.edit = ''
			
			model = if id? then new mDepartment('id': id) else new mDepartment()

			@view = new vEditDepartment 'model': model

		show: (id) ->
			@breadcrumbs = 'Departments': '/departments'
			@breadcrumbs[id] = ''
			
			@view = new vFullDepartment 'id': id

		list: ->
			@breadcrumbs = 'Departments': ''
			
			@view = new vDepartmentList()