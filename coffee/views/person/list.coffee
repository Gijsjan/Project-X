define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	sListedViews = require 'switchers/views.listed'
	cPeople = require 'collections/people'
	# vInputList = require 'views/input/list'
	# vInputTypeahead = require 'views/input/typeahead'
	vContainerAccordion = require 'views/ui/accordion'
	vPagination = require 'views/ui/pagination'
	tpl = require 'text!html/person/list.html'
	hlp = require 'helper'

	class vPeopleList extends BaseView

		id: 'peoplelist'

		initialize: ->
			# @filters =
			# 	'countries': []
			# 	'departments': []

			@filtereditems = new BaseCollection()
			@filtereditems.on 'reset', @renderCollection, @

			# @collection.fetch (31) and $.ajax (39) are queued
			# The interval checks when both are finished
			# queue = [null, null]
			# interval = setInterval (=>
			# 	if queue[0] is 'finished' and queue[1] is 'finished'
			# 		clearInterval interval
					
			# ), 100

			@collection = new cPeople 'dbview': 'user/user'
			@collection.fetch
				success: (collection, response) =>
					# console.log 'vFormatList.initialize() => fetch().success '
					# queue[0] = 'finished'
					@render()
					@filtereditems.reset @collection.models
				error: (collection, response) => @globalEvents.trigger response.status+''

			# ADD RESULT TO COLLECTIONMANAGER
			# @globalEvents.trigger 'ajaxGet',
			# 	'url': '_design/content/_view/formatSelectors?group=true'
			# 	'success': (data) =>
			# 		countries = new BaseCollection()
			# 		departments = new BaseCollection()

			# 		_.each data.rows, (row) ->
			# 			obj = row.key[2]
			# 			obj['count'] = row.value

			# 			countries.add obj if row.key[0] is 'country'
			# 			departments.add obj if row.key[0] is 'department'

			# 		@caCountry = new vContainerAccordion
			# 			'items': countries
			# 			'name': 'country'
			# 			'title': 'Country'
			# 		@caCountry.on 'selectionchanged', (items) =>
			# 			@filters.countries = items
			# 			@filterCollection()

			# 		@caDepartment = new vContainerAccordion
			# 			'items': departments
			# 			'name': 'department'
			# 			'title': 'Department'
			# 		@caDepartment.on 'selectionchanged', (items) =>
			# 			@filters.departments = items
			# 			@filterCollection()

			# 		queue[1] = 'finished'

			super

		# createButton: (value, id) ->
		# 	b = $('<button />').attr('id', id).attr('type', 'button').addClass('button btn-mini').html(value)
		# 	b.click =>
		# 		b.remove()
		# 		countryIndex = @filters.countries.indexOf(id)
		# 		departmentIndex = @filters.departments.indexOf(id)
		# 		@filters.countries.splice(countryIndex, 1) if countryIndex > -1
		# 		@filters.departments.splice(departmentIndex, 1) if departmentIndex > -1
		# 		@filterCollection()

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl
			# @$('#selectors').html @caCountry.render().$el
			# @$('#selectors').append @caDepartment.render().$el

			@

		renderCollection: ->
			@$('#list').html ''

			pagination = new vPagination 'itemCount': @filtereditems.length
			
			# div = $('<div />').attr('id', 'page1').addClass('show')
			# pagenumber = 1
			@filtereditems.each (model, i) =>
				t = new sListedViews[model.get 'type']
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

		# filterCollection: ->
		# 	@$('#list').removeClass('alert')
			
		# 	formats = @collection.filter (format) =>
		# 		hasCountry = false
		# 		hasDepartment = false

		# 		for country in @filters.countries
		# 			if _.has format.get('shortcut2countries'), country
		# 				hasCountry = true
		# 				break

		# 		if not hasCountry
		# 			for department in @filters.departments
		# 				if _.has format.get('shortcut2departments'), department
		# 					hasDepartment = true
		# 					break

		# 		hasCountry or hasDepartment

		# 	# reset filtered items to re-render the list
		# 	# if no formats are found, render the complete list (@collection.models)
		# 	if formats.length > 0 then @filtereditems.reset formats
		# 	else @filtereditems.reset @collection.models