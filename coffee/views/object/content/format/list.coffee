define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	sListedViews = require 'switchers/views.listed'
	vListedFormat = require 'views/object/content/format/listed'
	vInputList = require 'views/input/list'
	vInputTypeahead = require 'views/input/typeahead'
	vContainerAccordion = require 'views/container/accordion'
	vPagination = require 'views/main/pagination'
	cFormat = require 'collections/object/content/format'
	tpl = require 'text!html/format/list.html'
	hlp = require 'helper'

	class vFormatList extends BaseView

		id: 'formatlist'

		initialize: ->
			@filters =
				'countries': []
				'departements': []

			@filtereditems = new BaseCollection()
			@filtereditems.on 'reset', @renderCollection, @

			# @collection.fetch (31) and $.ajax (39) are queued
			# The interval checks when both are finished
			queue = [null, null]
			interval = setInterval (=>
				if queue[0] is 'finished' and queue[1] is 'finished'
					clearInterval interval
					@render()
					@filtereditems.reset @collection.models
			), 100

			@collection = new cFormat
				'dbview': 'content/format'
			@collection.fetch
				'success': (collection, response) =>
					# console.log 'vFormatList.initialize() => fetch().success '
					@modelManager.register collection.models # PUT IN BASECOLLECTION
					queue[0] = 'finished'
				'error': (collection, response) =>
					@navigate 'login' if response.status is 401

			# ADD RESULT TO COLLECTIONMANAGER
			@globalEvents.trigger 'ajaxGet'
				'url': '_design/content/_view/formatSelectors?group=true'
				'success': (data) =>
					countries = new BaseCollection()
					departements = new BaseCollection()

					_.each data.rows, (row) ->
						obj = row.key[2]
						obj['count'] = row.value

						countries.add obj if row.key[0] is 'country'
						departements.add obj if row.key[0] is 'departement'

					@caCountry = new vContainerAccordion
						'items': countries # CHANGE ITEMS TO COLLECTION?
						'name': 'country'
						'title': 'Country'
					@caCountry.on 'selectionchanged', (items) =>
						@filters.countries = items
						@filterCollection()

					@caDepartement = new vContainerAccordion
						'items': departements # CHANGE ITEMS TO COLLECTION?
						'name': 'departement'
						'title': 'Departement'
					@caDepartement.on 'selectionchanged', (items) =>
						@filters.departements = items
						@filterCollection()

					queue[1] = 'finished'
					
			# $.ajax
				# 'dataType': 'json'
				# 'error': (response) =>
				# 	@navigate 'login' if response.status is 401

			super

		createButton: (value, id) ->
			b = $('<button />').attr('id', id).attr('type', 'button').addClass('button btn-mini').html(value)
			b.click =>
				b.remove()
				countryIndex = @filters.countries.indexOf(id)
				departementIndex = @filters.departements.indexOf(id)
				@filters.countries.splice(countryIndex, 1) if countryIndex > -1
				@filters.departements.splice(departementIndex, 1) if departementIndex > -1
				@filterCollection()

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl

			@$('#selectors').html @caCountry.render().$el
			@$('#selectors').append @caDepartement.render().$el

			@

		renderCollection: ->
			@$('#list').html ''

			pagination = new vPagination 'itemCount': @filtereditems.length
			
			# div = $('<div />').attr('id', 'page1').addClass('show')
			# pagenumber = 1
			@filtereditems.each (model, i) =>
				t = new vListedFormat
					id: 'object-'+model.get 'id'
					className: 'content listed '+model.get 'type'
					model: model

				pagination.addItem t.render().$el, i

			# 	div.append t.render().$el

			# 	if (i+1) % pagination.itemsPerPage is 0
			# 		@$('#list').append div
			# 		div = $('<div />').attr('id', 'page'+(pagenumber+1)).addClass('hide')

			# @$('#list').append div if pagination.itemsPerPage % pagination.itemCount isnt 0
			@$('#list').append pagination.render().$el

		filterCollection: ->
			@$('#list').removeClass('alert')
			
			formats = @collection.filter (format) =>
				hasCountry = false
				hasDepartement = false

				for country in @filters.countries
					if _.has format.get('shortcut2countries'), country
						hasCountry = true
						break

				if not hasCountry
					for departement in @filters.departements
						if _.has format.get('shortcut2departements'), departement
							hasDepartement = true
							break

				hasCountry or hasDepartement

			# reset filtered items to re-render the list
			# if no formats are found, render the complete list (@collection.models)
			if formats.length > 0 then @filtereditems.reset formats
			else @filtereditems.reset @collection.models