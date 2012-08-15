define (require) ->
	cGroup = require 'collections/object/group/group'
	vObjectListControl = require 'views/object/list.control'
	vUserCommentList = require 'views/object/comment/list.user'

	Backbone.Router.extend
		
		routes:
			"groups": "groups"
			"groups/:group_type": "group_type"

			"departements": "departements"
			"organisations": "organisations"
			"projects": "projects"

			"group/:group_id/content": "content"
			"group/:group_id/content/:slug": "content_type"

			"group/:group_id/tag/:slug": "tag"
			"group/:group_id/country/:slug": "country"
			
			"group/:group_id/comments": "comments"
			
			"group/:group_id/users": "users"
			
			#"group/:group_id/groups": "groups"
			#"group/:group_id/group/:slug": "group"

		groups: ->
			olc = new vObjectListControl
				'collection': new cGroup()
			$('div#main').html olc.$el

		departements: ->
			@group_type 'departement'

		organisations: ->
			@group_type 'organisation'

		projects: ->
			@group_type 'project'

		group_type: (group_type) ->
			olc = new vObjectListControl
				'collection': new cGroup()
				preSelectedContent: [group_type]
			$('div#main').html olc.$el

		users: (group_id) ->
			console.log 'lala'


		###
		content: (group_id) ->
			lc = new vContentListControl
				'user': group_id
			$('div#main').html lc.$el

		content_type: (group_id, slug) ->
			lc = new vContentListControl
				'user': group_id
				'content_type': slug
			$('div#main').html lc.$el

		tag: (group_id, slug) ->
			lc = new vContentListControl
				'user': group_id
				'tag': slug
			$('div#main').html lc.$el

		country: (group_id, slug) ->
			lc = new vContentListControl
				'user': group_id
				'country': slug
			$('div#main').html lc.$el

		comments: (group_id) ->
			ucl = new vUserCommentList
				'user': group_id
			$('div#main').html ucl.$el
		###