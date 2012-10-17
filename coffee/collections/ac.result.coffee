define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseCollection = require 'collections/base'
	h = require 'helper'

	class cResult extends BaseCollection
		# url: ->
		# 	view = @view.split '/'
		# 	'/db/projectx/_design/'+view[0]+'/_view/'+view[1]

		initialize: (options) ->
			# console.log 'cResult.initialize()'
			# @view = if options? and options.view? then options.view else ''
			# @fetching = {}
			super
			
			@on 'reset', ->
				@highlighted = new Backbone.Model()

		# If a fetch is called several times from the same view (for example a form) the collectionManager
		# hasn't registered the url. This fetch function sets the first fetch() as fetching is true. The 
		# following fetches have a delay of 1,5 seconds which is a fine buffer. I have tried using an interval
		# to see when the first fetch is finished to let the following fetches continue, but have failed.
		# fetch: (options) ->
			# console.log 'cResult.fetch()'
			# if @collectionManager.fetching[@url()] is true
			# 	h.delay 1500, =>
			# 		super
			# else
			# 	@collectionManager.fetching[@url()] = true
			# 	super
			# super

		# COPIED FROM CFORMAT OR CCONTENT MAKE BASECOLLECTION?
		# sync: (method, collection, options) ->
		# 	# console.log 'cResult.sync()'
		# 	cachedResponse = @collectionManager.collections[@url()]

		# 	if method is 'read' and cachedResponse?
		# 		options.success(cachedResponse)
		# 	else
		# 		Backbone.sync(method, collection, options)

		# parse: (response) ->
		# 	# console.log 'cResult.parse()'
		# 	@collectionManager.register @url(), response
		# 	response.rows

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