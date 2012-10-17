define (require) ->
	_ = require 'underscore'
	BaseView = require 'views/base'
	tpl = require 'text!html/main/pagination.html'

	class vPagination extends BaseView

		className: 'paginator'

		events:
			"click li a": "onClick"

		onClick: (e) ->
			page = $(e.currentTarget).attr('data-page')
			if page is 'left' or page is 'right'
				console.log 'implemting later'
			else
				@showPage parseInt(page)

		initialize: ->
			@itemCount = @options.itemCount
			@itemsPerPage = 3

			@pageCount = Math.ceil @itemCount / @itemsPerPage

			@pages = {}
			for pagenumber in [1..@pageCount]
				div = $('<div />').attr('id', 'page'+pagenumber).addClass('page hide')
				@pages[pagenumber] = div

		addItem: (item, iterator) ->
			pagenumber = Math.ceil (iterator+1) / @itemsPerPage
			@pages[pagenumber].append item

		render: ->
			@$el.html _.template tpl
			
			if @pageCount > 1
				for i in [1..@pageCount]
					li = $('<li />')
					li.addClass('active') if i is 1
					@$('li:last').before li.html($('<a />').attr('data-page', i).attr('href', '#'+i).html(i))
				@$('ul').show()
			else
				@$('ul').hide()

			for own pagenumber, page of @pages
				@$('.pages').append page

			@showPage(1)

			@

		showPage: (pagenumber) ->
			@$('.disabled').removeClass('disabled')
			@$('.active').removeClass('active')
			@$('.show').removeClass('show').addClass('hide')

			@$('#page'+pagenumber).addClass('show').removeClass('hide')
			@$('a[href=#'+pagenumber+']').parent().addClass('active')

		# totalItems: 0

		# id: 'pagination-wrapper'

		# events:
		# 	"click li.pgn-nav-elem" : "changePage"
		# 	# keyup is bound to the document

		# initialize: ->
		# 	@pageCount = 0
		# 	@itemsPerPage = 4
		# 	@reset()

		# 	$(document).on 'keyup', (e) =>
		# 		if e.keyCode is 37 # left
		# 			@currentPage = if @currentPage > 1 then @currentPage - 1 else @currentPage = @pageCount	
		# 		else if e.keyCode is 39 # right
		# 			@currentPage = if @currentPage < @pageCount then @currentPage + 1 else @currentPage = 1
					
		# 		@trigger 'changePage'				

		# # reset is called from vListControl.render()
		# reset: ->
		# 	@currentPage = 1 # on load or user input: start at page one
		# 	@totalItems = 0 # set totalItems to zero; totalItems has to be recounted on load or user input

		# render: ->				
		# 	@pageCount = Math.ceil @totalItems / @itemsPerPage
			
		# 	@$el.html _.template tpl, pageCount: @pageCount

		# 	@renderNavigation()

		# 	@

		# renderNavigation: ->
		# 	@$('li.pgn-nav-elem').removeClass 'greyed-out'

		# 	@$('li[data-page-number="'+@currentPage+'"]').addClass 'greyed-out'

		# 	if @currentPage is 1 
		# 		@$('li.previous').addClass 'greyed-out'
		# 	if @currentPage is @pageCount
		# 		@$('li.next').addClass 'greyed-out'

		# changePage: (e) ->
		# 	target = $(e.currentTarget)
		# 	pagenumber = target.attr 'data-page-number'

		# 	if !target.hasClass('greyed-out')
		# 		if _.isString(pagenumber) # pagenumber is "2" or undefined
		# 			pagenumber = parseInt pagenumber # if pagenumber is "2" -> parseInt -> 2

		# 		if pagenumber?
		# 			@currentPage = pagenumber
		# 		else if target.hasClass 'previous'
		# 			@currentPage = @currentPage - 1
		# 		else if target.hasClass 'next'
		# 			@currentPage = @currentPage + 1

		# 	@trigger 'changePage'