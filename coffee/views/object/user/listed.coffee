define (require) ->
	_ = require 'underscore'
	tpl = require 'text!templates/user/listed.html'

	Backbone.View.extend
	
		render: ->
			tplr = _.template tpl, @model.toJSON()
			@$el.html tplr

			@