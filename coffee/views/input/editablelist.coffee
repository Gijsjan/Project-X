define (require) ->
	BaseView = require 'views/base'
	BaseCollection = require 'collections/base'
	Typeahead = require 'views/input/typeahead'
	Models = require 'switchers/models'
	tpl = require 'text!html/input/editablelist.html'
	hlp = require 'helper'

	class EditableList extends BaseView

		'className': 'editablelist'

		initialize: ->
			[@selecteditems, @config, @span] = [@options.value, @options.config, @options.span]

			@selecteditems.on 'add', @selecteditemsChanged, @
			@selecteditems.on 'remove', @selecteditemsChanged, @
			@selecteditems.on 'reset', @renderSelectedItems, @

			@typeahead = new Typeahead
				'collection': @config.collection
				'span': @span
				'selectfromlist': true
			@typeahead.on 'valuechanged', (item) => 
				item['access'] = 'read'
				@selecteditems.add item

			@render()

			super

		render: ->
			rtpl = _.template tpl
			@$el.html rtpl

			@$('section.typeahead').html @typeahead.$el

			@renderSelectedItems()

			@

		selecteditemsChanged: ->
			@renderSelectedItems()
			@trigger 'valuechanged', @selecteditems

		renderSelectedItems: ->
			@$('section.selecteditems ul').html ''

			@selecteditems.each (item) =>
				@$('section.selecteditems ul.nav').append @createElement(item)

		createElement: (item) ->
			[id, title] = [item.get('id'), item.get('title')]

			anchor = $('<a />').html title
			li = $('<li />').addClass('span'+@span).attr('id', id).html anchor

			anchor.hover(
				(-> anchor.append $('<i />').addClass('icon-remove icon-white pull-right')),
				(-> $('.icon-remove').remove()))
			li.click => @selecteditems.remove item
