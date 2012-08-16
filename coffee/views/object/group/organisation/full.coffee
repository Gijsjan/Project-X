define (require) ->
	_ = require 'underscore'
	vFullGroup = require 'views/object/group/full'
	vSmallList = require 'views/main/list.small'
	tpl = require 'text!html/organisation/full.html'
	
	vFullGroup.extend

		render: ->
			vFullGroup.prototype.render.apply @

			rtpl = _.template tpl, @model.toJSON()
			@$('.group-body').html rtpl

			rDepartements = new vSmallList 
				'collection': @model.get('departements')
			@$('.departements').html rDepartements.render().$el

			rProjects = new vSmallList 
				'collection': @model.get('projects')
			@$('.projects').html rProjects.render().$el

			@