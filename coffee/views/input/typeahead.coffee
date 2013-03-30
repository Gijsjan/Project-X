define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	bootstrap = require 'bootstrap'
	async = require 'async'
	BaseView = require 'views/base'
	vModal = require 'views/ui/modal'
	vInputList = require 'views/input/list'
	BaseModel = require 'models/base'
	BaseCollection = require 'collections/base'
	Models = require 'switchers/models'
	Collections = require 'switchers/collections'
	hlpr = require 'helper'
	tpl = require 'text!html/input/typeahead.html'

	# Typeahead shows an option list while typing an input
	# The list is filled with objects from a db call (@dbview) or an existing list (@items)
	# An object is passed to vInputTable when selected

	class Typeahead extends BaseView

		className: 'input-typeahead'

		events:
			'change': 'onChange'
			'blur': 'onBlur'
			'click button': 'onClickButton'

		onChange: (e) ->
			# console.log 'vInputTypeahead.onChange'
			@$el.removeClass 'warning'
			model = @alloptions.find (model) =>
				value = @$('input').val()
				# index = value.lastIndexOf(' (')
				# value = if index > -1 then value.substring(0, index) else value
				return model.get('title') is value

			# WHAT IF ALLOPTIONS LIST IS VERY LONG AND TAKING LONGER THAN 300 MS??? AND WHY IS IT NOT PROCEDURAL?
			hlpr.delay 300, => # delay is waiting for find() to finish
				if model?
					# @trigger 'valuechanged', model.toJSON()
					@valuechanged(model)
				else
					@$el.addClass 'warning'
					@valuechanged()
		
		onBlur: ->
			# console.log 'vInputTypeahead.onBlur'
			@valuechanged() if @$('input').val() is ''

		onClickButton: ->
			# console.log 'vInputTypeahead.onClickButton()'
			inputList = new vInputList
				'items': @alloptions

			modal = new vModal
				'view': inputList

			inputList.on 'itemselected', (item) => # when user clicks or gives enter on active option the itemselected event is triggered
				modal.hide()
				@$el.removeClass 'warning'
				@$('input').val item.get('title')
				@valuechanged(item)

			false

		valuechanged: (item = {}) ->
			@clear()
			@trigger 'valuechanged', item.toJSON()

		initialize: ->			
			{@span, @selectfromlist, @items, @collection} = @options
			@span = 2 if not @span?
			@selectfromlist = true if not @selectfromlist?
			@items = [] if not @items?
			@collectionTypes = if _.isString @collectionTypes then [@collection] else @collection

			@alloptions = new BaseCollection()

			getModels = (type, callback) ->
				new Collections[type]().fetch (response) => callback null, response.models
			
			async.map @collectionTypes, getModels, (err, allmodels) =>
				for models in allmodels
					@alloptions.add models
				@render()


			# if @items.length is 0
			# 	@alloptions = new Collections[@collections[0]]()
			# 	@alloptions.fetch => @render()
			# else
			# 	@alloptions = new Collections[@collections[0]] @items.models
			# 	@render()

		render: ->
			# model = @alloptions.get(@value)
			# value = if model? then model.get('title') else ""

			renderedHTML = _.template tpl,
				# 'value': value
				'span': @span
			@$el.html renderedHTML

			@$el.addClass 'control-group'
			if @selectfromlist
				@$('input').width @$('input').width() - 29 # the added icon is 29px wide, so subtract from input width to keep same width as other inputs
				@$el.addClass 'input-append'
				b = $('<button />').addClass('btn btn-narrow').html $('<i />').addClass('icon-list')
				@$el.append b

			@$('input').typeahead
				'source': @alloptions.pluck('title')

			@

		clear: ->
			@$('input').val ''