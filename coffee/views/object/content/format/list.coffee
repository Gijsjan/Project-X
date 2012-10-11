define (require) ->
	BaseView = require 'views/base'
	sListedViews = require 'switchers/views.listed'
	tpl = require 'text!html/format/list.html'

	class vFormatList extends BaseView

		id: 'formatlist'

		initialize: ->
			@collection.fetch
				'success': (collection, response) =>
					# console.log 'vFormatList.initialize() => fetch().success '
					@modelManager.register collection.models
					@render()
				'error': (collection, response) =>
					@navigate 'login' if response.status is 401

			super

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl
			
			@collection.each (model) =>
				t = new sListedViews[model.get 'type']
					id: 'object-'+model.get 'id'
					className: 'content listed '+model.get 'type'
					model: model

				@$('#list').append t.render().$el

			@
		# render: (currentPage = 1, itemsPerPage = 10) ->

		# 	getModel = (i) =>
		# 		if i < @collection.length
		# 			model = @collection.at(i)

		# 			if model.get 'show'
		# 				t = new sListedViews[model.get 'type']
		# 					id: 'object-'+model.get 'id'
		# 					className: 'content listed '+model.get 'type'
		# 					model: model

		# 				@$el.append t.render().$el

		# 	start = (currentPage - 1) * itemsPerPage
		# 	end = start + (itemsPerPage - 1)

		# 	getModel i for i in [start..end]

		# 	@