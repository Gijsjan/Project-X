define (require) ->
	mOrganistion = require 'models/group/organisation'
	vFull = require 'views/full'
	tpl = require 'text!html/group/organisation/full.html'

	class vFullOrganisation extends vFull

		initialize: ->
			@model = new mOrganistion 'id': @options.id

			super

		render: ->
			super

			rhtml = _.template tpl, @model.toJSON()
			@$('.full-body').html rhtml

			@