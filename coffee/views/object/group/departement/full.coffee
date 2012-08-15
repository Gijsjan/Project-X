define (require) ->
	vFullGroup = require 'views/object/group/full'
	vSmallList = require 'views/main/list.small'
	tpl = require 'text!templates/departement/full.html'
	
	vFullGroup.extend

		render: ->
			vFullGroup.prototype.render.apply @

			rtpl = _.template tpl, @model.toJSON()
			@$('.group-body').html rtpl

			rOrganisations = new vSmallList 'collection': @model.get('organisations')
			@$('.organisations').html rOrganisations.render().$el