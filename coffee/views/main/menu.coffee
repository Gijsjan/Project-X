define [
	    'jquery'
	    'underscore'
	    'backbone'
	    'text!../../../templates/main/menu'
	], ($, _, Backbone, tplMenu) ->
		Backbone.View.extend
			tagName: 'nav'
			id: 'main'
			events:
				"click #logout": "logout"
			logout: ->
				$.post('/api/logout').error (response) =>
					@navigate 'login' if response.status is 401
					return
			render: ->
				@$el.html _.template tplMenu
				@