define (require) ->
	BaseView = require 'views/base'
	cResult = require 'collections/ac.result'
	tpl = require 'text!html/input/list.html'
	hlpr = require 'helper'

	class vInputList extends BaseView

		basetop: 0 # var to hold the initial height of the first <li> in the <ul>

		events:
			'keyup input': 'onInputKeyup'
			'click ul li a': 'onClickItem'

		onInputKeyup: (e) ->
			active = @$('ul li.active')
			@$('ul li.active').removeClass('active')
			
			switch e.keyCode
				when 40 # Down
					if active.length is 0
						@$('ul li:first').addClass('active')
						@basetop = @$('ul li:first').position().top
					else 
						next = active.next()
						next.addClass('active')
					@adjustScroll()
				when 38 # Up
					if active.length is 0
						@$('ul li:last').addClass('active')
					else 
						active.prev().addClass('active')
					@adjustScroll()
				when 13 # Enter
					index = active.find('a').attr('data-index')
					@trigger 'itemselected', @filtereditems.at(index)
				else
					if e.target.value is ''
						@filtereditems.reset @items.models
					else if e.target.value isnt ''
						value = hlpr.slugify(e.target.value)
						@filtereditems.reset @items.filter((model) -> model.get('key').indexOf(value) isnt -1)

		adjustScroll: ->
			activepos = @$('.active').position().top
			ulpos = @$('ul.nav').position().top * -1

			if activepos < @basetop or activepos > @$('.overflow').height()
				@$('.overflow').scrollTop(ulpos+activepos-100)

		onClickItem: (e) ->
			index = $(e.currentTarget).attr('data-index')
			@trigger 'itemselected', @filtereditems.at(index)

		initialize: ->
			# console.log 'vInputList.initialize()'
			@dbview = if @options.dbview? then @options.dbview else '' # DBview is the name of the view in CouchDB ie: 'object/countries'
			@items = if @options.items? then @options.items else ''

			@on 'reset', @reset, @
			
			# create filtered items before fetching all items
			@filtereditems = new cResult()
			@filtereditems.on 'reset', @renderItems, @

			if @items is '' and @dbview isnt ''
				# create and fetch all items, render view and reset @filtereditems
				@items = new cResult 'dbview': @dbview
				@items.fetch
					'success': (collection, response) =>
						# console.log 'vInputList.initialize() @items.fetch() success'
						@render()
						@filtereditems.reset collection.models
					'error': (collection, response) =>
						# console.log 'vInputList.initialize() @items.fetch() error'
						@navigate 'login' if response.status is 401
			else
				@render()
				@filtereditems.reset @items.models

		reset: ->
			@$('.overflow').scrollTop(0)

		render: ->
			# console.log 'vInputList.render()'
			renderedHTML = _.template tpl
			@$el.html renderedHTML

			@

		renderItems: ->
			# console.log 'vModal.renderItems()'
			ul = @$ 'ul.nav'
			ul.html ''
			@filtereditems.each (item, index) ->
				html = item.get('value')
				html = html + ' ('+item.get('count')+')' if item.get('count')?

				a = $('<a />').attr('data-index', index).html html
				li = $('<li />').html a
				ul.append li