define (require) ->
	BaseView = require 'views/base'
	cResult = require 'collections/ac.result'
	tpl = require 'text!html/main/modal.html'
	hlpr = require 'helper'

	class vModal extends BaseView

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
					else 
						next = active.next()
						next.addClass('active')
				when 38 # Up
					if active.length is 0
						@$('ul li:last').addClass('active')
					else 
						active.prev().addClass('active')
				when 13 # Enter
					index = active.find('a').attr('data-index')
					@trigger 'itemselected', @filtereditems.at(index)
				else
					if e.target.value isnt ''
						value = hlpr.slugify(e.target.value)
						@filtereditems.reset @items.filter((model) -> model.get('key').indexOf(value) isnt -1)

		onClickItem: (e) ->
			index = $(e.currentTarget).attr('data-index')
			@trigger 'itemselected', @filtereditems.at(index)

		initialize: ->
			@items = @options.items

			@filtereditems = new cResult()
			@filtereditems.on 'reset', @renderItems, @

			@filtereditems.reset @options.items.models

		render: ->
			renderedHTML = _.template tpl
			@$el.html renderedHTML

			@renderItems()

			@

		renderItems: ->
			# console.log 'vModal.renderItems()'
			ul = @$ 'ul.nav'
			ul.html ''
			@filtereditems.each (item, index) ->
				a = $('<a />').attr('data-index', index).html item.get('value')
				li = $('<li />').html a
				ul.append li