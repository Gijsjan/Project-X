define (require) ->
	_ = require 'underscore'
	vFullObject = require 'views/object/full'
	tpl = require 'text!html/user/full.html'

	class vFullUser extends vFullObject

		# overrides vFullObject.initialize()
		# initialize: ->
		# 	@globalEvents.on 'userLoaded', @userLoaded, @

		# userLoaded: (user) ->
		# 	@model = user
		# 	@render()
	
		render: ->
			console.log 'vFullUser.render()'
			super

			rhtml = _.template tpl, @model.toJSON()
			@$el.html rhtml

			@