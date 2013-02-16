define (require) ->
	Backbone = require 'backbone'
	
	class ViewManager

		'currentView': {}
		
		constructor: ->
			@views = new Backbone.Collection()

		show: (view, render = false) ->
			@currentView = view

			html = if render then view.render().$el else view.$el

			$('div#main').html html

		register: (view) ->
			view.on "rendered", -> view.delegateEvents()
			# console.log 'ViewManager.register()'
			model = new Backbone.Model
				id: view.cid
				class: view.constructor 
				view: view

			@views.add model

	new ViewManager()
		