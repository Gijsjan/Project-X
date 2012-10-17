define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	mUser = require 'models/object/user'
	tpl = require 'text!html/main/menu.html'

	class vMenu extends BaseView

		initialize: ->
			@globalEvents.on 'userLoaded', @userLoaded, @

		userLoaded: (user) ->
			@user = user
			@render()

		render: ->
			@$el.html _.template tpl,
				'username': @user.get 'name'
			
			$('body').prepend @$el