define (require) ->
	vContentListControl = require 'views/object/content/list.control'
	vUserCommentList = require 'views/object/comment/list.user'

	Backbone.Router.extend
		routes:
			# user/:user_id is caught by :object_type/:id in routers/object.cofee
			
			
			"user/:user_id/content": "content"
			"user/:user_id/content/:slug": "content_type"
			"user/:user_id/tag/:slug": "tag"
			"user/:user_id/country/:slug": "country"
			"user/:user_id/comments": "comments"
			#"user/:user_id/contacts": "contacts"
			"user/:user_id/groups": "groups"
			"user/:user_id/group/:slug": "group"

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




