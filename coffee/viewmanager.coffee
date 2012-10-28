define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	
	class ViewManager
		
		constructor: (globalEvents) ->
			@views = new Backbone.Collection()
			@currentView = new Backbone.View()

			globalEvents.on 'registerView', (view) => @register view
			globalEvents.on 'unregisterView', (view) => @unregister view
			globalEvents.on 'showView', (options) => @show options

		show: (options) ->
			# console.log 'ViewManager => show'
			@currentView = options.currentView
			html = if options.render then @currentView.render().$el else @currentView.$el
			
			$('div#main').html html # the view is rendered after the model is fetched from the server in the views initialize function

		register: (view) ->
			# console.log 'ViewManager => registering '+view.cid
			model = new Backbone.Model
				id: view.cid
				class: view.constructor 
				view: view

			@views.add model

		# unregister: (view) ->
		# 	#console.log 'ViewManager => unregistering '+view.cid
		# 	view.off()
		# 	view.remove()

		# 	model = @views.get view.cid
		# 	@views.remove model

		currentViewToLog: ->
			console.log @currentView

		viewsToLog: ->
			console.log @views
		