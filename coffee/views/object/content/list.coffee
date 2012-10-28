define (require) ->
	BaseView = require 'views/base'
	sListedViews = require 'switchers/views.listed'

	class vContentList extends BaseView

		id: 'contentlist'

		initialize: ->
			@$el.addClass('span6')

			@collection.fetch
				'success': (collection, response) =>
					# console.log 'ContentList.initialize() => fetch().success '
					@render()
				error: (collection, response) => @globalEvents.trigger response.status+''

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

					if model.get 'show'
						t = new sListedViews[model.get 'type']
							id: 'object-'+model.get 'id'
							className: 'content listed '+model.get 'type'
							model: model

						@$el.append t.render().$el

			start = (currentPage - 1) * itemsPerPage
			end = start + (itemsPerPage - 1)

			getModel i for i in [start..end]

			@