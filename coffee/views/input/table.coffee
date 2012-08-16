###
TRIGGERS:
	- 'data changed'
###
define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	cInputTableRows = require 'collections/input/tablerow'
	mInputTableRow = require 'models/input/tablerow'
	vInputAutocomplete = require 'views/input/autocomplete'
	vInputSelect = require 'views/input/select'
	tpl = require 'text!html/input/table.html'
	hlpr = require 'helper'

	class vInputTable extends BaseView

		### EVENTS ###

		events:
			'click .add-row': 'addRow'
			'click td.input': 'onClickInputTD'
			'click td.remove': 'onRemove'
			'change input': 'onChangeInput'
			'change textarea': 'onChangeInput'

		addRow: (e) ->
			@rows.push new mInputTableRow
			###
			inputTR = $('<tr />').addClass('input')
			inputTR.append $('<td />').addClass('index').html(@rows.length + 1)

			for column, index in @columns
				td = $('<td />').addClass('input')
				column.input.type = 'text' if column.input.type is 'options'
				@renderInput column, td, new mInputTableRow
				inputTR.append td

			inputTR.append $('<td />')

			@$('table').append inputTR
			###

			###
			@$('td.remove').html 'x' if @$('tr.input').length is 1

			tr = @$('tr.input').last().clone()
			oldrownumber = @$('tr.input').last().find('td.index').html()
			tr.find('td.index').html parseInt(oldrownumber) + 1 # set the new row number
			_(tr.find ':input').each (te) -> 
				te.removeAttribute 'style' # Remove style="" from every textarea to reset the height
				te.removeAttribute 'data-value' # Remove style="" from every textarea to reset the height
				$(te).val ''
			@$('table').append tr # append new <tr> to <table>
			###

		# Sometimes the <td> is bigger than the <textarea>, set focus to the textarea when the user clicks inside the <td>
		onClickInputTD: (e) ->
			$(e.currentTarget).find(':input').focus()

		onRemove: (e) ->
			cid = e.currentTarget.dataset.cid
			@rows.remove @rows.getByCid(cid)

			###
			if @$('tr.input').length > 1 and confirm('Remove row?')
				$(e.currentTarget).parent().remove() # Remove <tr>
				@updateModel() # Renew the model

				# Set new row numbers for each <td class="index">
				_(@$('td.index')).each (td, index) ->
					$(td).html index + 1
				
				@$('td.remove').html '&nbsp;' if @$('tr.input').length is 1
			###	
		# Update the model when <textarea> changes
		onChangeInput: (e) ->
			if e.currentTarget.dataset.constrain? and e.currentTarget.dataset.constrain is 'percentage'
				amount = $(e.currentTarget).val()
				$(e.currentTarget).val hlpr.toPercentage(amount)

			if e.currentTarget.dataset.relation? and e.currentTarget.dataset.relation is 'sum'
				inputs = @$('input[data-key="'+e.currentTarget.dataset.key+'"]')

				totaltd = $('td[data-key="'+e.currentTarget.dataset.key+'"]')
				@renderTotalPercentage totaltd, hlpr.getSumFromInputs(inputs)

			@updateModel()

		### /EVENTS ###

		initialize: ->
			@attribute = @options.attribute
			@columns = @options.columns
			@addrows = @options.addrows

			@rows = if @options.rows? then @options.rows else new cInputTableRows
			@rows.on 'remove', (model, collection, options) =>
				@$('tr[data-cid='+model.cid+']').remove()
				@render()
			@rows.on 'add', (model, collection, options) =>
				@render()
				
			@rowlength = if @rows.length > 0 then @rows.length else 3
			
			super

		render: ->
			# Render the table, the cols, tr.headings, tr.totals and div.add-row
			html = _.template tpl,
				'rowlength': @rowlength
				'columns': @columns
				'headings': @headings

			@$el.html html

			# If the collection @rows is empty (ie: the models @attribute is empty) set @rows to default
			# If a column.input.type is set to 'options' (ie: a fixed list), use the length of column.input.options as @rows size
			# The empty @rows collection is filled with 'size' numbers of mInputTableRow's
			if @rows.length is 0
				size = @rowlength;
				for column, index in @columns
					size = column.input.options.length if column.input.type is 'options'
				itrs = (new mInputTableRow for i in [1..size])
	
				@rows.reset itrs
			
			@rows.each (row, index) => 
				@renderRow(row, index)

			# After rendering the rows, render the columns (ie: options, constrains and relations)
			@renderColumns()
	
			@

		# Each row is programmatically created and put before the tr.totals (the last row).
		# @param row = mInputTableRow || holds the row data (attributes: {'role': 'value', 'departement': {}, 'hours': 'value'})
		# @param rowindex = int || count of the row, starting at 0
		renderRow: (row, rowindex) ->
			inputTR = $('<tr />').addClass('input').attr('data-cid', row.cid)
			inputTR.append $('<td />').addClass('index').html(rowindex + 1)

			for column, columnindex in @columns
				td = $('<td />').addClass('input')
				@renderInput column, td, row if column.input.type isnt 'options'
				inputTR.append td

			removeTD = if @addrows then $('<td />').attr('data-cid', row.cid).addClass('remove').html('x') else $('<td />').html('&nbsp;')

			inputTR.append removeTD

			@$('tr.totals').before inputTR

		renderColumns: ->
			for column, columnindex in @columns
				tds = @$ 'tr.input td:nth-child('+(columnindex+2)+')' # Column + 2 cuz array starts at 0 and first column is row count

				for td, rowindex in tds
					row = @rows.at(rowindex)

					if column.input.type is 'options'
						value = if row.get(column.key)? then row.get(column.key) else column.input.options[rowindex]
						$(td).attr('data-key', column.key).html value 

					if column.input.constrain?

						switch column.input.constrain

							when 'percentage'
								amount = row.get(column.key)
								$(td).find(':input').val hlpr.toPercentage(amount)

				if column.relation?

					switch column.relation.type

						when 'sum'
							input = @$ 'tr.totals td:nth-child('+(columnindex+2)+')'
							input.attr 'data-key', column.key
							input.attr 'data-relation', column.relation.type
							@$('tr.totals').show()
							
							sum = hlpr.getSumFromInputs tds.find(':input')
							totaltd = @$('td.total[data-key="'+column.key+'"]')
							@renderTotalPercentage totaltd, sum

		# Renders the input element (text, textarea, autocomplete, select)
		# @param column = {} || holds the column information (width, input.type, etc)
		# @param td = $('<td />') || the <td> wrapped in Jquery
		# @param row = mInputTableRow
		renderInput: (column, td, row) ->
			value = row.get(column.key)
			
			switch column.input.type

				when 'text'
					input = $('<input />').attr('data-key', column.key).val(value)

					input.attr('data-constrain', column.input.constrain) if column.input.constrain?
					input.attr('data-relation', column.relation.type) if column.relation?

					td.html input

				when 'textarea'
					td.html $('<textarea />').attr('data-key', column.key).val(value)

				when 'autocomplete'
					iac = new vInputAutocomplete
						'view': column.input.view # departements
						'key': column.key # departement_id
						'row': row # model with all the data for this row, is used to set the new value
					iac.on 'option selected', @updateModel, @
					td.html iac.render().$el

				when 'select'
					inputselect = new vInputSelect
						'options': column.input.options
						'key': column.key
						'row': row
					inputselect.on 'option selected', @updateModel, @
					td.html inputselect.render().$el

		###
		renderInputs: (column, columnindex, rows) ->
			tds = @$ 'tr.input td:nth-child('+(columnindex+2)+')' # Column + 2 cuz array starts at 0 and first column is row count

			for td, rowindex in tds

				row = if rows.at(rowindex)? then rows.at(rowindex) else new mInputTableRow()

				switch column.input.type

					when 'text'
						input = $('<input />').attr('data-key', column.key).val(row.get(column.key))

						input.attr('data-constrain', column.input.constrain) if column.input.constrain?
						input.attr('data-relation', column.input.relation) if column.input.relation?

						$(td).html input

					when 'textarea'
						$(td).html $('<textarea />').attr('data-key', column.key).val(row.get(column.key))

					when 'autocomplete'
						iac = new vInputAutocomplete
							'view': column.input.view # departements
							'key': column.key # departement_id
							'row': row # model with all the data for this row, is used to set the new value
						iac.on 'option selected', @updateModel, @
						$(td).html iac.render().$el

					when 'select'
						inputselect = new vInputSelect
							'options': column.input.options
							'key': column.key
							'row': row
						inputselect.on 'option selected', @updateModel, @
						$(td).html inputselect.render().$el

					when 'options'
						$(td).attr('data-key', column.key).html column.input.options[rowindex]

				if column.input.constrain?

					switch column.input.constrain

						when 'percentage'
							amount = row.get(column.key)
							$(td).find(':input').val hlpr.toPercentage(amount)

			if column.relation?

				switch column.relation.type

					when 'sum'
						sum = hlpr.getSumFromInputs tds.find(':input')
						totaltd = @$('td.total[data-key="'+column.key+'"]')
						@renderTotalPercentage totaltd, sum
		###

		renderTotalPercentage: (td, amount) ->
			td.removeClass 'error'
			td.removeClass 'incomplete'
			td.removeClass 'complete'
			td.addClass 'error' if amount > 100
			td.addClass 'incomplete' if 0 < amount < 100
			td.addClass 'complete' if amount is 100
			td.html amount + '%'

		updateModel: ->
			@trigger 'data changed', 
				'attr': @attribute
				'data': @table2object()

		# Convert the <table> to a JS object
		table2object: ->
			array = []

			rows = @$('tr.input')
			_(rows).each (row) =>
				inputs = $(row).find('[data-key]')
				tmp = {}
				tr_values = ''

				_(inputs).each (input, index) =>
					key = $(input).attr 'data-key'
					value = $(input).attr 'data-value'

					if not value?
						value = if $(input).is(':input') then $(input).val() else $(input).html()

					tr_values = tr_values + value

					tmp[key] = value

				array.push tmp if tr_values isnt '' # If the combined values of the row is empty then don't add to array 

			array