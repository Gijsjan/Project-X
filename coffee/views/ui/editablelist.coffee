define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	# BaseCollection = require 'collections/base'
	# sListedViews = require 'switchers/views.listed'
	# cPeople = require 'collections/people'
	# vInputList = require 'views/input/list'
	Typeahead = require 'views/input/typeahead'
	# vContainerAccordion = require 'views/ui/accordion'
	# vPagination = require 'views/ui/pagination'
	tpl = require 'text!html/ui/editablelist.html'
	hlp = require 'helper'

	class vEditableList extends BaseView

		'className': 'editablelist'

		initialize: ->
			[@value, @dbview, @span] = [@options.value, @options.dbview, @options.span]

			@selecteditems = new BaseCollection()
			@selecteditems.on 'add', @selecteditemsChanged, @
			@selecteditems.on 'remove', @selecteditemsChanged, @
			@selecteditems.on 'reset', @renderSelectedItems, @

			@typeahead = new Typeahead
				'dbview': @dbview
				'span': @span
				'selectfromlist': true
			@typeahead.on 'valuechanged', (item) => @selecteditems.add item

			@render()

			super

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl

			@$('section.typeahead').html @typeahead.$el
			@selecteditems.reset @value

			@

		selecteditemsChanged: ->
			@renderSelectedItems()
			@trigger 'valuechanged', @selecteditems

		renderSelectedItems: ->
			@$('section.selecteditems ul').html ''

			@selecteditems.each (item) =>
				@$('section.selecteditems ul').append @createElement(item)

		createElement: (item) ->
			[id, title] = [item.get('id'), item.get('title')]

			# if type is 'button'
			# 	el = $('<button />').attr('id', id).attr('type', 'button').addClass('button btn-mini').html(title)
			# else if type is 'list'
			anchor = $('<a />').html title
			li = $('<li />').addClass('span'+@span).attr('id', id).html anchor

			anchor.hover(
				(-> anchor.append $('<i />').addClass('icon-remove icon-white pull-right')),
				(-> $('.icon-remove').remove()))
			li.click => @selecteditems.remove item
