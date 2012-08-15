define (require) ->
	BaseView = require 'views/base'
	sListedViews = require 'switchers/views.listed'

	class ContentList extends BaseView

		id: 'contentlist'

		initialize: ->
			@collection.fetch
				'success': (collection, response) =>
					@render()

			super


		###
		collectionChanged: (model) ->
			if model.get('show')
				@$('#object-'+model.get('id')).show()
			else 
				@$('#object-'+model.get('id')).hide()
		###

		render: (currentPage = 1, itemsPerPage = 10) ->

			getModel = (i) =>
				if i < @collection.length
					model = @collection.at(i)

					if model.get '_show'
						t = new sListedViews[model.get 'type']
							id: 'object-'+model.get 'id'
							className: 'content listed '+model.get 'type'
							model: model

						@$el.append t.render().$el

			start = (currentPage - 1) * itemsPerPage
			end = start + (itemsPerPage - 1)

			getModel i for i in [start..end]

			@