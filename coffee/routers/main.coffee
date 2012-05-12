define [
	    'views/content/list'
	    'views/main/login'
	], (vContentList, vLogin) ->
		Backbone.Router.extend
			routes:
				"": "home",
				'all': 'all',
				"login": "login"
			home: ->
				home = new vContentList()
				$('div#main').html home.$el
			all: ->
				all = new vContentList()
				$('div#main').html all.$el
			login: ->
				$('div#main').html new vLogin().render().$el