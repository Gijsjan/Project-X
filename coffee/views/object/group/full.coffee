define (require) ->
	_ = require 'underscore'
	vFullObject = require 'views/object/full'
	vSmallList = require 'views/main/list.small'
	tpl = require 'text!templates/group/full.html'

	vFullObject.extend
	
		render: ->
			vFullObject.prototype.render.apply @

			tplr = _.template tpl, @model.toJSON()
			@$el.html tplr
			
			console.log @model.get('users')
			rUsers = new vSmallList 'collection': @model.get('users')
			@$('.users').html rUsers.render().$el

			@