define (require) ->
	_ = require 'underscore'
	tpl = require 'text!html/main/pagination.pages.html'

	class PagesPagination extends Backbone.View

		tagName: 'ul'

		className: 'pagination'

		events:
			"click li.pagination" : "onClick"
			# keyup is bound to the document in initialize()

		onClick: (e) ->
			target = $ e.currentTarget
			@previousPage = @currentPage

			if not target.hasClass 'greyed-out'
				@currentPage = pagenumber if pagenumber = parseInt target.attr('data-pagenumber') # if attr? then pagenumber = "2" else undefined
				@currentPage = @currentPage - 1 if target.hasClass 'previous'	
				@currentPage = @currentPage + 1 if target.hasClass 'next'

			@changePage()

		initialize: ->
			@previousPage = 0
			@parent = @options.parent
			@hash = parseInt @options.hash
			@totalPages = parseInt @parent.$el.find('div.page:last-child').attr('data-pagenumber')

			@currentPage = if $.isNumeric(@hash) and 0 < @hash <= @totalPages then @hash else 1 # $.isNumeric also fails on NaN (which is good)
			
			@pageTitles = []
			_.each @parent.$el.find('h3.page-title'), (el) =>
				@pageTitles.push $(el).html()

			@render()

			#@pageTitles = []
			#@pageTitles = if @options.pageTitles? then @options.pageTitles else 

			# arrow navigation doesn't work as expected
			# it is hard to add and remove the events cuz route event fires too late
			# the arrow navigation shouldn't work when using textarea's
			###
			$(document).on 'keyup', (e) =>
				if e.keyCode is 37 # left
					@currentPage = if @currentPage > 1 then @currentPage - 1 else @currentPage = @totalPages	
				else if e.keyCode is 39 # right
					@currentPage = if @currentPage < @totalPages then @currentPage + 1 else @currentPage = 1
					
				@trigger 'changePage'				
			###

		render: ->
			@$el.html _.template tpl,
				'totalPages': @totalPages
				'pageTitles': @pageTitles

			@changePage()

			@parent.$el.find('nav.pages').html @$el

		changePage: (options) ->
			# If options exists and the hash is numeric, set currentPage to the user generated hash

			if options? and $.isNumeric(options.hash)
				@previousPage = @currentPage
				@currentPage = if 0 < options.hash <= @totalPages then parseInt(options.hash) else 1 # If the user entered a value not in range, go to page 1

			if @currentPage isnt @previousPage # do not react to hashchange when hash is set by code and thus prevent double animation  
				window.location.hash = '#' + @currentPage

				# set the greyed-out class
				@$('li.pagination').removeClass 'greyed-out'
				@$('li[data-pagenumber="'+@currentPage+'"]').addClass 'greyed-out'
				@$('li.previous').addClass 'greyed-out' if @currentPage is 1
				@$('li.next').addClass 'greyed-out' if @currentPage is @totalPages

				offset = @previousPage - @currentPage # Calculate difference between previousPage and currentPage, -1 for one page to the left, +3 for 3 pages to the right, etc
				direction = if offset < 0 then '-' else '+' # Page to left gets a '-', page to the right gets a '+'

				@parent.$el.find('div#pages').animate
					'marginLeft': direction + '=' + Math.abs(offset * 900) + 'px'
				@parent.$el.find('div.page[data-pagenumber='+@previousPage+']').animate
					'opacity': 0
				@parent.$el.find('div.page[data-pagenumber='+@currentPage+']').animate
					'opacity': 1