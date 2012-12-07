define (require) ->
	Backbone = require 'backbone'
	
	class ViewManager

		'currentView': {}
		
		constructor: ->
			@views = new Backbone.Collection()
			# @currentView = new Backbone.View()

			# ev.on 'registerView', (view) => @register view
			# globalEvents.on 'unregisterView', (view) => @unregister view
			# globalEvents.on 'showView', (options) => @show options

		show: (view, render = false) ->
			# console.log 'ViewManager => show'
			@currentView = view

			html = if render then view.render().$el else view.$el
			
			$('div#main').html html

		register: (view) ->
			# console.log 'ViewManager.register()'
			model = new Backbone.Model
				id: view.cid
				class: view.constructor 
				view: view

			@views.add model

	new ViewManager()
		