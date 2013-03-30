define (require) ->
	Views =	
		Base: require 'views/base'
		Pagination: require 'views/ui/pagination'
	Switchers =
		Collections: require 'switchers/collections'
		Listed: require 'switchers/views.listed'

	class List extends Views.Base

		id: 'list'

		initialize: ->	
			[@type] = [@options.type]
			
			if not @items? # @items can be defined in parent class
				@type = @model.type if not @type and @model?
				@items = new Switchers.Collections[@type]() if @type?

			if not @collection?
				@items.fetch => @render()
			else
				@items = @collection
				@render()

			super

		render: ->
			@$el.html ''

			pagination = new Views.Pagination 'itemCount': @items.length
			
			@items.each (model, i) =>
				t = new Switchers.Listed[model.type]
					'model': model
				pagination.addItem t.render().$el, i

			@$el.append pagination.render().$el

			@