define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	sListedViews = require 'switchers/views.listed'
	cPeople = require 'collections/people'
	vContainerAccordion = require 'views/ui/accordion'
	vPagination = require 'views/ui/pagination'
	tpl = require 'text!html/person/list.html'
	hlp = require 'helper'

	class vPeopleList extends BaseView

		# id: 'peoplelist'

		# initialize: ->

		# 	@filtereditems = new BaseCollection()
		# 	@filtereditems.on 'reset', @renderCollection, @

		# 	@collection = new cPeople 'dbview': 'user/user'
		# 	@collection.fetch (collection, response) =>
		# 		@render()
		# 		@filtereditems.reset @collection.models

		# 	super

		# render: ->
		# 	rtpl = _.template tpl
		# 	@$el.html rtpl

		# 	@

		# renderCollection: ->
		# 	@$('#list').html ''

		# 	pagination = new vPagination 'itemCount': @filtereditems.length

		# 	@filtereditems.each (model, i) =>
		# 		t = new sListedViews[model.type]
		# 			id: 'object-'+model.get 'id'
		# 			className: 'content listed '+model.get 'type'
		# 			model: model

		# 		pagination.addItem t.render().$el, i

		# 	@$('#list').append pagination.render().$el