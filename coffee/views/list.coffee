define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	ev = require 'EventDispatcher'
	vPagination = require 'views/ui/pagination'
	Switcher = require 'switchers/switcher'
	tpl = require 'text!html/content/note/list.html'

	class vList extends BaseView

		id: 'list'

		initialize: ->			
			@filters = {}

			@render()

			@filtereditems = new Switcher.Collections[@model.type]()
			@filtereditems.on 'reset', @renderCollection, @

			@collection = new Switcher.Collections[@model.type]() # @type is set in the child views initialize()
			@collection.fetch (collection, response) => @filtereditems.reset collection.models

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
				t = new Switcher.Views.Listed[@model.type]
					'model': model

				pagination.addItem t.render().$el, i

			@$('#list').append pagination.render().$el