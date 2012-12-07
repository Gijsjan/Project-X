define (require) ->
	_ = require 'underscore'
	mPerson = require 'models/person'
	vFull = require 'views/full'
	tpl = require 'text!html/person/full.html'

	class vFullPerson extends vFull

		# overrides vFullObject.initialize()
		# initialize: ->
		# 	@globalEvents.on 'userLoaded', @userLoaded, @

		# userLoaded: (user) ->
		# 	@model = user
		# 	@render()

		initialize: ->
			@model = new mPerson 'id': @options.id

			super
	
		render: ->
			# console.log 'vFullPerson.render()'
			super

			rhtml = _.template tpl, @model.toJSON()
			@$el.html rhtml

			@