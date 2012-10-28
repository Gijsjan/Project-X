define (require) ->
	Backbone = require 'backbone'
	vAdminHome = require 'views/admin/home'

	class AdminRouter extends Backbone.Router
		
		routes:
			'admin/home': 'home'

		home: ->
			home = new vAdminHome()
			$('div#main').html home.$el