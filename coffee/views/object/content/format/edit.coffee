define (require) ->
	# _ = require 'underscore'
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	vEditContent = require 'views/object/content/edit'
	vTabination = require 'views/main/tabination'
	vInputTable = require 'views/input/table'
	vModalContainer = require 'views/container/modal'
	vContentSettings = require 'views/object/content/settings'
	cInputTableRow = require 'collections/input/tablerow'
	config = require 'config/object/content/format'
	hlpr = require 'helper'

	class vEditFormat extends vEditContent

		events:
			"click h2 small": "showInfo"

		showInfo: ->
			info = new vContentSettings
				'model': @model
			new vModalContainer
				'view': info
				'title': '"'+@model.get('title')+'" settings'

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
				# If value is not an cInputTableRow (on server load or new) convert to cInputTableRow
				value = new cInputTableRow value if not (value instanceof cInputTableRow)

				options = _.extend(configdata, 'tablekey': key, 'tablevalue': value) # Extend the config with tablekey (string) and value (cInputTableRow)

				v = new vInputTable options
				v.on 'valuechanged', @setModel, @ # If the value (cInputTableRow) changes, set the model
				
				@$('section.'+key).html v.render().$el

			# CHANGE TO TABINATION?
			pgn = new vTabination 'parent': @ # the url hash for linking to page: /content/link/bla2bli#p1 => hash = p1
			pgn.on 'tabshown', @adjustTextareas, @
			@$('nav.pages').html pgn.render().$el

			hlpr.delay 0, @adjustTextareas # add delay of 0 to queue the adjusting, see: http://stackoverflow.com/questions/9502774/backbone-js-trigger-an-event-on-a-view-after-the-render

			@

		adjustTextareas: ->
			_.each @$('.tab-pane.active textarea'), (textarea) ->
				$(textarea).height textarea.scrollHeight # set the proper heights for textarea's

		# - setModel is triggered by a change event on an vInputTable
		# - the input table returns a key as a string and a value as an object
		# - the value from the input table has to be turned into a string if the 
		#   corresponding value in the model is a string 
		setModel: (key, value) ->
			obj = {}
			if _.isString @model.get(key)
				obj = value[0] 
			else
				obj[key] = value
			@model.set obj, 'silent': true # silent true is added to avoid validation