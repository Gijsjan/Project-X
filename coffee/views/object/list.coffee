# PAGINATION
# PAGINATION
# PAGINATION

define (require) ->
	sListedViews = require 'switchers/views.listed'

	Backbone.View.extend

		id: 'list'

		render: (currentPage = 1, itemsPerPage = 10) ->
			@$el.html ''

			renderModel = (i) =>
				if i < @collection.length
					model = @collection.at(i)

					if model.show
						t = new sListedViews[model.get 'type']
							'id': 'object-'+model.get 'id'
							'className': 'content listed '+model.get 'type'
							'model': model
							
						@$el.append t.render().$el

			start = (currentPage - 1) * itemsPerPage
			end = start + (itemsPerPage - 1)

			renderModel i for i in [start..end]

			@