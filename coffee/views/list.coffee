define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	vPagination = require 'views/ui/pagination'
	# Switcher = require 'switchers/switcher'
	Collections = require 'switchers/collections'
	Listed = require 'switchers/views.listed'

	class List extends BaseView

		id: 'list'

		initialize: ->	
			[@type] = [@options.type]
			
			if not @items? # @items can be defined in parent class
				@type = @model.type if not @type
				@items = new Collections[@type]()

			@items.fetch => @render()

			super

		render: ->
			@$el.html ''

			pagination = new vPagination 'itemCount': @items.length
			
			@items.each (model, i) =>
				t = new Listed[@type]
					'model': model

				pagination.addItem t.render().$el, i

			@$el.append pagination.render().$el

			@