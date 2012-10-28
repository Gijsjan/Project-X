define (require) ->
	vContentListControl = require 'views/object/content/list.control'
	vUserCommentList = require 'views/object/comment/list.user'
	FullViews = require 'switchers/views.full'
	mUser = require 'models/object/user'
	cUser = require 'collections/object/user'
	vFullUser = require 'views/object/user/full'
	vEditUser = require 'views/object/user/edit'
	vUserList = require 'views/object/user/list'


	class UserRouter extends Backbone.Router
		routes:
			"people/new": "edit"
			"people/:id/edit": "edit"
			"people/:id": "showUser"
			"people": "listUsers"

			"user/:user_id/content": "content"
			"user/:user_id/content/:slug": "content_type"
			"user/:user_id/tag/:slug": "tag"
			"user/:user_id/country/:slug": "country"
			"user/:user_id/comments": "comments"
			#"user/:user_id/contacts": "contacts"
			"user/:user_id/groups": "groups"
			"user/:user_id/group/:slug": "group"

		showUser: (id) ->
			# console.log 'UserRouter.showUser()'
			
			model = new mUser 'id': id
			view = new vFullUser 'model': model 

			@globalEvents.trigger 'showView',
				'render': false
				'currentView': view

		edit: (id) ->
			model = if id? then new mUser('id': id) else new mUser()

			ev = new vEditUser 'model': model
			ev.on 'done', (model) ->
				# console.log 'ContentRouter.edit() ' + object_type + ' || EditView || saved!'
				@navigate 'people/' + id, true

			# USE VIEWMANAGER
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': ev

		listUsers: ->
			# console.log 'UserRouter.listUsers()'
			view = new vUserList()
			
			@globalEvents.trigger 'showView',
				'render': false
				'currentView': view

		content: (user_id) ->
			lc = new vContentListControl
				'user': user_id
			$('div#main').html lc.$el

		content_type: (user_id, slug) ->
			lc = new vContentListControl
				'user': user_id
				'content_type': slug
			$('div#main').html lc.$el

		tag: (user_id, slug) ->
			lc = new vContentListControl
				'user': user_id
				'tag': slug
			$('div#main').html lc.$el

		country: (user_id, slug) ->
			lc = new vContentListControl
				'user': user_id
				'country': slug
			$('div#main').html lc.$el

		comments: (user_id) ->
			ucl = new vUserCommentList
				'user': user_id
			$('div#main').html ucl.$el

		#groups: (user_id) ->




