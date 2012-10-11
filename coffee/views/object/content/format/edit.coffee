define (require) ->
	# _ = require 'underscore'
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	vEditContent = require 'views/object/content/edit'
	vPagination = require 'views/main/pagination.pages'
	vInputTable = require 'views/input/table'
	cInputTableRow = require 'collections/input/tablerow'
	config = require 'config/object/content/format'
	hlpr = require 'helper'

	class vEditFormat extends vEditContent

		render: ->
			super

			# - Loop over the config json to render all vInputTables
			for own key, configdata of config
				value = @model.get key

				# All inputs (text, textarea, select, etc) are vInputTables, so plain text has to be turned into an object		
				if _.isString value
					data = {}
					data[key] = value
					value = data

				# The vInputTable converts a collection of tablerow data into a table, so the tablevalue is a cInputTableRow
				value = new cInputTableRow value

				options = _.extend(configdata, 'tablekey': key, 'tablevalue': value) # Extend the config with tablekey (string) and value (cInputTableRow)

				v = new vInputTable options
				v.on 'valuechanged', @setModel, @ # If the value (cInputTableRow) changes, set the model
				
				@$('section.'+key).html v.render().$el

			# CHANGE TO TABINATION?
			pgn = new vPagination 'parent': @ # the url hash for linking to page: /content/link/bla2bli#p1 => hash = p1
			pgn.on 'tabshown', @adjustTextareas, @
			@$('nav.pages').html pgn.render().$el

			@adjustTextareas()

			@

		adjustTextareas: ->
			_.each @$('.tab-pane.active textarea'), (textarea) ->
				$(textarea).height textarea.scrollHeight # set the proper heights for textarea's

		# - setModel is triggered by a change event on an vInputTable
		# - the input table returns a key as a string and a value as an object
		# - the value from the input table has to be turned into a string if the 
		#   corresponding value in the model is a string 
		setModel: (key, value) ->
			value = value[0][key] if _.isString @model.get(key)
			@model.set key, value