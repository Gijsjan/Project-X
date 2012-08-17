define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class cResult extends Backbone.Collection
		url: ->
			view = @view.split '/'
			'/db/projectx/_design/'+view[0]+'/_view/'+view[1]

		initialize: (options) ->
			# console.log @
			@view = options.view

			@on 'reset', ->
				@highlighted = new Backbone.Model()

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