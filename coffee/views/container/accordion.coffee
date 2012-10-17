# vContainerAccordion creates a Twitter Bootstrap accordion-group
# Actually it's two accordion-groups: the second holds the selected items
# The first group has a title and a vInputTypeahead in the accordion-heading,
# the body holds an vInputList. When the body is shown, the typeahead is hidden.
# When the selection changes, a 'selectionchanged' event is triggered

define (require) ->
	BaseView = require 'views/base'
	sListedViews = require 'switchers/views.listed'
	vInputList = require 'views/input/list'
	vInputTypeahead = require 'views/input/typeahead'
	tpl = require 'text!html/container/accordion.html'
	hlp = require 'helper'

	class vContainerAccordion extends BaseView

		selecteditems: []

		initialize: ->
			@dbview = if @options.dbview? then @options.dbview else ''
			@items = if @options.items? then @options.items else ''
			@name = @options.name
			@title = if @options.title? then @options.title else hlp.ucfirst @options.name

			@ta = new vInputTypeahead
				'dbview': @dbview
				'items': @items
			@ta.on 'valuechanged', (obj) =>
				if obj.id isnt ''
					@ta.$('input').val('')
					@addSelectedItem obj.id, obj.value

			@il = new vInputList
				'dbview': @dbview
				'items': @items
			@il.on 'itemselected', (model) => # when user clicks or gives enter on active option the itemselected event is triggered
				@$('#'+@name).collapse('hide') # close the accordion-body
				@addSelectedItem model.get('id'), model.get('value')

			super

		addSelectedItem: (item, value) ->
			index = @selecteditems.indexOf(item)

			if index is -1
				@$('#'+@name+'-selected').append @createButton(item, value)
				@selecteditems.push item
				@trigger 'selectionchanged', @selecteditems

		removeSelectedItem: (item) ->
			index = @selecteditems.indexOf(item)
				
			if index > -1
				@selecteditems.splice(index, 1)
				@trigger 'selectionchanged', @selecteditems

		createButton: (id, value) ->
			b = $('<button />').attr('type', 'button').addClass('button btn-mini').html(value)
			b.click =>
				b.remove()
				@removeSelectedItem id

		render: ->
			rtpl = _.template tpl,
				'name': @name
				'title': @title
			@$el.html rtpl

			@$('#'+@name+'-heading').append @ta.render().$el
			@$('#'+@name+' .accordion-inner').html @il.$el


			@$('#'+@name).on 'show', =>
				@il.trigger 'reset'
			@$('#'+@name).on 'shown', =>
				@$('.input-typeahead').css('visibility', 'hidden')
			@$('#'+@name).on 'hidden', =>
				@$('.input-typeahead').css('visibility', 'visible')
			@