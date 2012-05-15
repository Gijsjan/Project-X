define [
	    'text!../../../templates/main/pagination'
	], (tpl) ->
		Backbone.View.extend
			currentPage: 0
			totalPages: 0
			itemsPerPage: 8
			totalItems: 0
			id: 'pagination-wrapper'
			events:
				"click li.pgn-nav-elem" : "changePage"
			initialize: ->
				@totalItems = @options.totalItems
				@totalPages = Math.ceil @totalItems / @itemsPerPage
				@pageDivs = []
			addPage: ->
				@currentPage++

				pageDiv = $('<div />').attr 'class', 'page index-'+@currentPage

				@pageDivs[@currentPage - 1] = pageDiv
			addItem: (index, itemDiv) ->
				if index % @itemsPerPage is 0
					@addPage()
				@pageDivs[@currentPage - 1].append itemDiv
			render: ->
				@currentPage = 1

				@$el.html _.template tpl, totalPages: @totalPages

				_.each @pageDivs, (pageDiv) =>
					@$('#item-wrapper').append pageDiv

				@showPage(1) if @pageDivs.length > 0

				@
			renderNavigation: ->
				if @pageDivs.length < 2
					@$('nav#pagination').hide()

				@$('li.pgn-nav-elem').removeClass 'greyed-out'

				@$('li[data-page-number="'+@currentPage+'"]').addClass 'greyed-out'

				if @currentPage is 1 
					@$('li.previous').addClass 'greyed-out'
				if @currentPage is @totalPages
					@$('li.next').addClass 'greyed-out'

				return
			changePage: (e) ->
				target = $(e.currentTarget)
				pagenumber = target.attr 'data-page-number'

				if !target.hasClass('greyed-out')
					if _.isString(pagenumber) # pagenumber is "2" or undefined
						pagenumber = parseInt pagenumber # if pagenumber is "2" -> parseInt -> 2

					if pagenumber?
						@showPage(pagenumber)
					else if target.hasClass 'previous'
						@showPage @currentPage - 1
					else if target.hasClass 'next'
						@showPage @currentPage + 1
			showPage: (pagenumber) ->
				@pageDivs[@currentPage - 1].hide()
				@currentPage = pagenumber
				@renderNavigation()
				@pageDivs[@currentPage - 1].show()