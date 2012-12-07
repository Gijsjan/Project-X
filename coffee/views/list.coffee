define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	ev = require 'EventDispatcher'
	vPagination = require 'views/ui/pagination'
	sCollections = require 'switchers/collections'
	sListedViews = require 'switchers/views.listed'
	tpl = require 'text!html/content/note/list.html'

	class vList extends BaseView

		id: 'list'

		initialize: ->
			# console.log 'vList.initialize()'
			@filters = {}

			@render()

			@filtereditems = new BaseCollection()
			@filtereditems.on 'reset', @renderCollection, @

			@collection = new sCollections[@type]() # @type is set in the child views initialize()
			@collection.fetch
				success: (collection, response) => @filtereditems.reset collection.models
				error: (collection, response) => ev.trigger response.status+''

			super

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl

			@

		renderCollection: ->
			# console.log 'vList.renderCollection()'
			@$('#list').html ''

			pagination = new vPagination 'itemCount': @filtereditems.length
			
			@filtereditems.each (model, i) =>
				t = new sListedViews[@type]
					'model': model

				pagination.addItem t.render().$el, i

			@$('#list').append pagination.render().$el