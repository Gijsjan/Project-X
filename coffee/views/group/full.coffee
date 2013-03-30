define (require) ->
	mGroup = require 'models/group.full'
	Full = require 'views/full'
	tpl = require 'text!html/group/full.html'

	class Group extends Full

		initialize: ->
			@model = new mGroup 'id': @options.id

			super

		render: ->
			super

			rhtml = _.template tpl, @model.toJSON()
			@$('.full-body').html rhtml

			@