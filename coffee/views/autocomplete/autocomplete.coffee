define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	vAutoCompleteList = require 'views/autocomplete/list'
	cResult = require 'collections/ac.result'
	hlpr = require 'helper'

	Backbone.View.extend

		id: 'ac-list'

		# Event is fired from parent view
		onKeyup: (keycode, value) ->
			switch keycode
				when 40 then @onPressArrow('down')
				when 38 then @onPressArrow('up')
				when 13 then @onPressEnter(value)
				when 188 then @onPressComma()
				else
					if value.length > 2
						if @fetchedJSON[value]?
							@result.reset @fetchedJSON[value]
						else
							$.getJSON('/api/ac/'+@options.input_id+'/'+value, (list) =>
								@fetchedJSON[value] = list
								@result.reset list
							).error((response) =>
								@navigate 'login' if response.status is 401
							)
					else
						@hideACList()

		initialize: ->
			@fetchedJSON = {}

			@result = new cResult
				'type': @options.input_id # Collection with the last result
			@result.on 'reset', @render, @

		renderList: ->
			list = new vAutoCompleteList
				'collection': @collection

			list.render().$el


		render: (list) ->
			@$el.html ''
			
			@$el.css 'position', 'fixed'
			@$el.css 'margin-top', '24px'
			@$el.css 'background-color', 'pink'
			@$el.css 'top', @options.position.top
			@$el.css 'left', @options.position.left
			
			@result.each (model) =>
				@$el.append $('<div />', 
					'class': 'ac-option'
					'id': 'ac-option-'+model.get('id')
					'text': model.get('title'))
			
			$('body').append @$el

			@$el.show()

		onPressArrow: (direction) ->
			if direction is 'down'
				@result.selectNext()
			else if direction is 'up'
				@result.selectPrev()

			@$('.selected').removeClass 'selected'
			@$('#ac-option-' + @result.selected.get 'id').addClass 'selected'

		onPressEnter: (value) ->
			value = hlpr.slugify value

			if @result.selected.isNew() # Is a model from the result list selected (isNew() is false) or has the user entered the full name in the input (isNew() is true)?
				model = @result.find (model) ->
					model.get('slug') is value

				@collection.add model if model?
			else
				@collection.add @result.selected

			@hideACList()

		onPressComma: ->

		hideACList: ->
			@$el.hide()