define (require) ->
	mDepartment = require 'models/group/department'
	vFull = require 'views/full'
	tpl = require 'text!html/group/department/full.html'

	class vFullDepartment extends vFull

		initialize: ->
			@model = new mDepartment 'id': @options.id

			super

		render: ->
			super

			rhtml = _.template tpl, @model.toJSON()
			@$('.full-body').html rhtml

			@