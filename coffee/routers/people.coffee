define (require) ->
	BaseRouter = require 'routers/base'
	mPerson = require 'models/person.full'
	vFullPerson = require 'views/person/full'
	vEditPerson = require 'views/person/edit'
	vList = require 'views/list'


	class PeopleRouter extends BaseRouter

		'routes':
			"person/new": "edit"
			"person/:id/edit": "edit"
			"person/:id": "show"
			"people": "list"

			# "user/:user_id/content": "content"
			# "user/:user_id/content/:slug": "content_type"
			# "user/:user_id/tag/:slug": "tag"
			# "user/:user_id/country/:slug": "country"
			# "user/:user_id/comments": "comments"
			# #"user/:user_id/contacts": "contacts"
			# "user/:user_id/groups": "groups"
			# "user/:user_id/group/:slug": "group"

		show: (id) ->
			# console.log 'UserRouter.show()'
			@breadcrumbs = 'People': '/people'
			@breadcrumbs[id] = ''
			
			@view = new vFullPerson 'id': id

		edit: (id) ->
			@breadcrumbs = 'People': '/people'
			
			if id?
				@breadcrumbs[id] = '/people/'+id
				@breadcrumbs.edit = ''
			else 
				@breadcrumbs.new = ''

			model = if id? then new mPerson('id': id) else new mPerson()

			@view = new vEditPerson 'model': model

		list: ->
			@breadcrumbs = 'People': ''
			# console.log 'UserRouter.list()'
			@view = new vList
				'type': 'person'

		# content: (user_id) ->
		# 	lc = new vContentListControl
		# 		'user': user_id
		# 	$('div#main').html lc.$el

		# content_type: (user_id, slug) ->
		# 	lc = new vContentListControl
		# 		'user': user_id
		# 		'content_type': slug
		# 	$('div#main').html lc.$el

		# tag: (user_id, slug) ->
		# 	lc = new vContentListControl
		# 		'user': user_id
		# 		'tag': slug
		# 	$('div#main').html lc.$el

		# country: (user_id, slug) ->
		# 	lc = new vContentListControl
		# 		'user': user_id
		# 		'country': slug
		# 	$('div#main').html lc.$el

		# comments: (user_id) ->
		# 	ucl = new vUserCommentList
		# 		'user': user_id
		# 	$('div#main').html ucl.$el

		# #groups: (user_id) ->




 