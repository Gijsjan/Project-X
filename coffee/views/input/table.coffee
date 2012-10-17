# @trigger 'valuechanged'
# 		@param 'attr' @tablekey
#		@param 'data' @table2object()
#
define (require) ->
	# _ = require 'underscore'
	# Backbone = require 'backbone'
	jqueryui = require 'jqueryui'
	BaseView = require 'views/base'
	cInputTableRow = require 'collections/input/tablerow'
	mInputTableRow = require 'models/input/tablerow'
	# vInputAutocomplete = require 'views/input/autocomplete'
	vInputTypeahead = require 'views/input/typeahead'
	vInputTextarea = require 'views/input/textarea'
	vInputSelect = require 'views/input/select'
	vWarning = require 'views/main/warning'
	# tpl = require 'text!html/input/table.html'
	hlpr = require 'helper'

	class vInputTable extends BaseView

		className: 'input'

		### EVENTS ###

		events:
			'click .add-row': 'addRow'
			'change input[data-key]': 'onChangeInput'
			'hover .row:not(.headings)': 'hoverRow'
			'click .removerow': 'removeRow'
			# 'click td.input': 'onClickInputTD'
			# 'click td.remove': 'onRemove'
			# 'change td[data-input=text] > input': 'onChangeInput' # use td[data-input=text] cuz input is used for select and ac and we don't want a double listener
			# 'change textarea': 'onChangeInput'

		# OPTIMALISATION: HOVER WORKS ALSO ON TABLES WITHOUT MOVABLE ROWS
		hoverRow: (e) ->
			switch e.type
				when 'mouseenter'
					$(e.currentTarget).find('.rownumber').animate opacity:1, duration: 'fast'
					$(e.currentTarget).find('.removerow').animate opacity:1, duration: 'fast'
				when 'mouseleave'
					# add a delay to make sure the mouseenter animation is over
					hlpr.delay 500, -> $(e.currentTarget).find('.rownumber').animate opacity:0, duration: 'fast'
					hlpr.delay 500, -> $(e.currentTarget).find('.removerow').animate opacity:0, duration: 'fast'

		addRow: (e) ->
			attrs = {}
			for column, index in @columns
				attrs[column.key] = ''
			@tablevalue.push new mInputTableRow(attrs) # add model to end of collection

		removeRow: (e) ->
			# console.log 'vInputTable.removeRow()'
			rowdiv = $(e.currentTarget).parents('div.row:first') # set rowdiv before the warning, otherwise whole page is removed, don't ask me why
			cid = rowdiv.attr('data-cid')
			
			v = new vWarning()
			v.on 'ok', =>
				rowdiv.fadeOut =>
					@tablevalue.removeByCid(cid)

		# Update the model when <textarea> changes
		onChangeInput: (e) ->
			# console.log 'vInputTable.onChangeInput()'
			cid = $(e.currentTarget).parents('div.row:first').attr('data-cid')
			key = e.currentTarget.dataset.key
			value = $(e.currentTarget).val()

			if e.currentTarget.dataset.constrain? and e.currentTarget.dataset.constrain is 'percentage'
				$(e.currentTarget).val hlpr.toPercentage(value)

			if e.currentTarget.dataset.relation? and e.currentTarget.dataset.relation is 'sum'
				inputs = @$('input[data-key="'+key+'"]')

				totaltd = $('td[data-key="'+key+'"]')
				@renderTotalPercentage totaltd, hlpr.getSumFromInputs(inputs)

			@tablevalue.getByCid(cid).set(key, value)


		### /EVENTS ###

		initialize: ->
			@tablekey = @options.tablekey
			@tablevalue = @options.tablevalue

			@tabletitle = @options.title
			@columns = @options.columns
			@addrows = @options.addrows

			@tablevalue.on 'remove', (model, collection, options) =>
				@$('tr[data-cid='+model.cid+']').remove()
				@render()
				@updateModel()
			@tablevalue.on 'add', (model, collection, options) =>
				@render()
			@tablevalue.on 'change', (model, options) =>
				@updateModel()
			
			@rowlength = if @tablevalue.length > 0 then @tablevalue.length else 3
			
			super

		renderTitle: ->
			navul = $('<ul />').addClass('nav nav-pills')
			navli = $('<li />')
			nava = $('<a />').html(@tabletitle)

			if @addrows			
				nava.addClass('dropdown-toggle').attr('data-toggle', 'dropdown')
				navb = $('<b />').addClass('caret')
				nava.append navb
				
				
				ddli = $('<li />')
				dda = $('<a />').addClass('add-row').html('Add row')
				ddli.html dda

				ddul = $('<ul />').addClass('dropdown-menu')
				ddul.html ddli

				navli.addClass('dropdown')
				navli.append(ddul)

			navli.prepend(nava)
			navul.html navli

			navul

		render: ->
			# Render the table, the cols, tr.headings, tr.totals and div.add-row
			# html = _.template tpl,
			# 	'rowlength': @rowlength
			# 	'columns': @columns
			# 	'addrows': @addrows
			@$el.html ''

			@$el.html @renderTitle()

			@$el.append @renderHeadings() if @columns[0].heading

			# If the collection @tablevalue is empty (ie: the models @tablekey is empty) set @tablevalue to default
			# If a column.input.type is set to 'options' (ie: a fixed list), use the length of column.input.options as @tablevalue size
			# The empty @tablevalue collection is filled with 'size' numbers of mInputTableRow's
			if @tablevalue.length is 0
				size = @rowlength;
				rowoptionskey = '' # string for column.key if column.input.type is rowoptions
				rowoptions = [] # array for column.input.options if column.input.type is rowoptions
				attrs = {} # the attributes to load in the mInputTableRow model
				itrs = [] # mInputTableRowS

				for column, index in @columns
					if column.input.type is 'rowoptions' # of the column type is rowoptions, then size and data changes
						rowoptionskey = column.key
						rowoptions = column.input.options
						size = rowoptions.length # override size if column.input.type is rowoptions
					attrs[column.key] = '' # set the attributes for the mInputTableRow

				# itrs = (new mInputTableRow attrs for i in [1..size])
				
				for i in [0..(size-1)]
					attrs[rowoptionskey] = rowoptions[i] if rowoptionskey isnt '' # add the rowoptions to the rows if the rowoptionskey is set
					itrs.push(new mInputTableRow attrs)

				@tablevalue.reset itrs

			
			@tablevalue.each (row, index) =>
				@$el.append @renderRow(row, index)

			# After rendering the tablevalue, render the columns (ie: options, constrains and relations)
			@renderColumns()

			# @el.html table

			@$el.sortable 'handle': '.rownumber'
	
			@

		renderHeadings: ->
			rowdiv = $('<div />').addClass('headings row')
			rowdiv.append $('<div />').addClass('span1 half').html('&nbsp;')
			for column, index in @columns
				cell = $('<div />').addClass('heading').addClass('span'+column.span).html column.heading
				rowdiv.append cell
			rowdiv.append $('<div />').addClass('span1 half').html('&nbsp;')
			rowdiv

		# Each row is programmatically created and put before the tr.totals (the last row).
		# @param row = mInputTableRow || holds the row data (attributes: {'role': 'value', 'departement': {}, 'hours': 'value'})
		# @param rowindex = int || count of the row, starting at 0
		renderRow: (row, rowindex) ->
			rowdiv = $('<div />').addClass('row').attr('data-cid', row.cid)

			rownumber = if @addrows then $('<span />').addClass('badge').html(rowindex + 1) else '&nbsp;'
			rowdiv.append $('<div />').addClass('span1 half rownumber hidden').html(rownumber)
			
			for column, columnindex in @columns
				cell = $('<div />').addClass('cell span'+column.span)
				@renderInput column, cell, row if column.input.type isnt 'options'
				rowdiv.append cell

			i = $('<i />').addClass('icon-trash')
			removerow = if @addrows then $('<a />').addClass('btn btn-small').html(i) else '&nbsp;'
			rowdiv.append $('<div />').addClass('span1 half removerow hidden').html(removerow)

			rowdiv

			###
			inputTR = $('<tr />').attr('data-cid', row.cid)

			indexTD = if @addrows then $('<td />').html(rowindex + 1) else $('<td />').html('&nbsp;')
			inputTR.append indexTD

			for column, columnindex in @columns
				td = $('<td />')
				@renderInput column, td, row if column.input.type isnt 'options'
				inputTR.append td

			removeTD = if @addrows then $('<td />').attr('data-cid', row.cid).html('x') else $('<td />').html('&nbsp;')
			inputTR.append removeTD

			@$('tr.totals').before inputTR
			###
		renderColumns: ->

			for column, columnindex in @columns
				controlsrows = @$('.row:not(.headings)') # Column + 2 cuz array starts at 0 and first column is row count
				cells = _.map(controlsrows, (rw) -> $(rw).find('.cell').eq(columnindex))

				for cell, rowindex in cells
					row = @tablevalue.at(rowindex)

					if column.input.type is 'rowoptions'
						if column.input.options[rowindex]?
							$(cell).attr('data-key', column.key).html column.input.options[rowindex]
						else
							$(cell).html $('<input />').addClass('span'+column.span).attr('type', 'text').attr('data-key', column.key)

					if column.input.constrain?

						switch column.input.constrain

							when 'percentage'
								amount = row.get(column.key)
								$(cell).find(':input').val hlpr.toPercentage(amount)

				# if column.relation?

				# 	switch column.relation.type

				# 		when 'sum'
				# 			input = @$ 'tr.totals cell:nth-child('+(columnindex+2)+')'
				# 			input.attr 'data-key', column.key
				# 			input.attr 'data-relation', column.relation.type
				# 			@$('tr.totals').show()
							
				# 			sum = hlpr.getSumFromInputs cells.find(':input')
				# 			totalcell = @$('cell.total[data-key="'+column.key+'"]')
				# 			@renderTotalPercentage totalcell, sum

		# Renders the input element (text, textarea, autocomplete, select)
		# @param column = {} || holds the column information (width, input.type, etc)
		# @param cell = $('<div />') || a div with class=span3
		# @param row = mInputTableRow
		renderInput: (column, cell, row) ->
			value = row.get(column.key)

			cell.attr('data-input', column.input.type)
			
			switch column.input.type

				when 'text'
					input = $('<input />').addClass('span'+column.span).attr('type', 'text').attr('data-key', column.key).val(value).attr('data-cid', row.cid)

					input.attr('data-constrain', column.input.constrain) if column.input.constrain?
					input.attr('data-relation', column.relation.type) if column.relation?

					div = $('<div />').html(input)
					
					if column.input.prepend? or column.input.append?
						if column.input.prepend?
							div.addClass('input-prepend')
							div.prepend $('<span />').addClass('add-on').html(column.input.prepend)
						if column.input.append?
							div.addClass('input-append')
							div.append $('<span />').addClass('add-on').html(column.input.append)

					cell.html div

				when 'textarea'
					view = new vInputTextarea
						'key': column.key
						'model': row
					renderedView = view.render().$el.addClass('span'+column.span)
					cell.html renderedView

				when 'typeahead'
					ta = new vInputTypeahead
						'value': row.get(column.key)
						'dbview': column.input.dbview
						'span': column.span
						'selectfromlist': true
					ta.on 'valuechanged', (value) ->
						row.set column.key, value

					renderedView = ta.render().$el
					cell.html renderedView

				# CHANGE TO TYPEAHEAD STYLE
				when 'select'
					view = new vInputSelect
						'row': row
						'column': column
					# inputselect.on 'option selected', @updateModel, @
					renderedView = view.render().$el
					cell.html renderedView

		renderTotalPercentage: (td, amount) ->
			td.removeClass 'error'
			td.removeClass 'incomplete'
			td.removeClass 'complete'
			td.addClass 'error' if amount > 100
			td.addClass 'incomplete' if 0 < amount < 100
			td.addClass 'complete' if amount is 100
			td.html amount + '%'

		updateModel: ->
			console.log 'vInputTable.updateModel()'
			console.log @tablevalue.map((model) -> model.attributes)
			@trigger 'valuechanged', @tablekey, @tablevalue.map (model) -> model.attributes