define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseCollection = require 'collections/base'
	mListItem = require 'models/listitem'
	h = require 'helper'

	class cListItems extends BaseCollection # CHANGE TO cListResult ?
		# url: ->
		# 	view = @view.split '/'
		# 	'/db/projectx/_design/'+view[0]+'/_view/'+view[1]
		'model': mListItem

		url: ->
			dbview = @dbview.split '/'
			'/db/projectx/_design/'+dbview[0]+'/_view/'+dbview[1]

		initialize: (options) ->
			# console.log 'cResult.initialize()'
			# @view = if options? and options.view? then options.view else ''
			# @fetching = {}
			super
			
			@on 'reset', ->
				@highlighted = new Backbone.Model()

		parse: (response) ->
			# console.log 'BaseCollection.parse()'

			@collectionManager.register @url(), response
			response.rows

		highlight: (model) ->
			@highlighted = model
			@trigger 'model highlighted', model.get 'id'

		highlightByID: (id) ->
			@highlight @get(id)

		highlightNext: ->
			index = @indexOf(@highlighted)

			model = if @at(index + 1)? then @at(index+1) else @first()
			@highlight model

		highlightPrev: ->
			index = @indexOf(@highlighted)
			
			model = if @at(index - 1)? then @at(index-1) else @last()
			@highlight model