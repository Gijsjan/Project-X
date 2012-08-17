define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditContent = require 'views/object/content/edit'
	vPagination = require 'views/main/pagination.pages'
	vInputTable = require 'views/input/table'
	config = require 'config/object/content/format'

	class vEditFormat extends vEditContent

		render: ->
			super

			@pgn = new vPagination
				parent: @
				hash: @options.hash # the url hash for linking to page: /content/link/bla2bli#p1 => hash = p1
			@on 'hashchange', @pgn.changePage, @pgn # Change page when window.onhashchange is triggerd in app.js || 'hashchange' is bound to currentView

			# Loop over the config json to render all InputTables			
			for own key, value of config
				options = _.extend(value, 'tablekey': key, 'tablevalue': @model.get(key)) # Extend the config with tablekey (string) and tablevalue (cInputTableRows)
				it = new vInputTable options
				it.on 'valuechanged', @setModel, @ # If the tablevalue (cInputTableRows) changes, set the model
				@$('div.'+key).html it.render().$el

			_.each $('textarea'), (textarea) -> $(textarea).height textarea.scrollHeight # set the proper heights for textarea's

		setModel: (key, value) ->
			@model.set key, value