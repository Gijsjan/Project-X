define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	sListedViews = require 'switchers/views.listed'
	vListedNote = require 'views/object/content/note/listed'
	# vInputList = require 'views/input/list'
	# vInputTypeahead = require 'views/input/typeahead'
	# vContainerAccordion = require 'views/container/accordion'
	vPagination = require 'views/main/pagination'
	cNote = require 'collections/object/content/note'
	tpl = require 'text!html/content/list.html'
	hlp = require 'helper'

	class vNoteList extends BaseView

		id: 'notelist'

		initialize: ->
			# console.log 'vNoteList.initialize()'
			@filters = {}

			@render()

			@filtereditems = new BaseCollection()
			@filtereditems.on 'reset', @renderCollection, @

			@collection = new cNote()
				# 'dbview': 'content/Note'
			@collection.fetch
				'success': (collection, response) =>
					# console.log 'vNoteList.initialize() => fetch().success '
					@filtereditems.reset collection.models
				'error': (collection, response) =>
					console.log response

			super

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl

			@

		renderCollection: ->
			# console.log 'vNoteList.renderCollection()'
			@$('#list').html ''

			pagination = new vPagination 'itemCount': @filtereditems.length
			
			@filtereditems.each (model, i) =>
				t = new vListedNote
					id: 'object-'+model.get 'id'
					className: 'note listed'
					model: model

				pagination.addItem t.render().$el, i

			@$('#list').append pagination.render().$el