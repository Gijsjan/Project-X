define (require) ->
	_ = require 'underscore'
	tpl = require 'text!templates/main/pagination.html'

	Backbone.View.extend

		totalItems: 0

		id: 'pagination-wrapper'

		events:
			"click li.pgn-nav-elem" : "changePage"
			# keyup is bound to the document

		initialize: ->
			@totalPages = 0
			@itemsPerPage = 4
			@reset()

			$(document).on 'keyup', (e) =>
				if e.keyCode is 37 # left
					@currentPage = if @currentPage > 1 then @currentPage - 1 else @currentPage = @totalPages	
				else if e.keyCode is 39 # right
					@currentPage = if @currentPage < @totalPages then @currentPage + 1 else @currentPage = 1
					
				@trigger 'changePage'				

		# reset is called from vListControl.render()
		reset: ->
			@currentPage = 1 # on load or user input: start at page one
			@totalItems = 0 # set totalItems to zero; totalItems has to be recounted on load or user input

		render: ->				
			@totalPages = Math.ceil @totalItems / @itemsPerPage
			
			@$el.html _.template tpl, totalPages: @totalPages

			@renderNavigation()

			@

		renderNavigation: ->
			@$('li.pgn-nav-elem').removeClass 'greyed-out'

			@$('li[data-page-number="'+@currentPage+'"]').addClass 'greyed-out'

			if @currentPage is 1 
				@$('li.previous').addClass 'greyed-out'
			if @currentPage is @totalPages
				@$('li.next').addClass 'greyed-out'

		changePage: (e) ->
			target = $(e.currentTarget)
			pagenumber = target.attr 'data-page-number'

			if !target.hasClass('greyed-out')
				if _.isString(pagenumber) # pagenumber is "2" or undefined
					pagenumber = parseInt pagenumber # if pagenumber is "2" -> parseInt -> 2

				if pagenumber?
					@currentPage = pagenumber
				else if target.hasClass 'previous'
					@currentPage = @currentPage - 1
				else if target.hasClass 'next'
					@currentPage = @currentPage + 1

			@trigger 'changePage'