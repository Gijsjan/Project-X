define (require) ->
	vFullGroup = require 'views/object/group/full'
	tpl = require 'text!templates/project/full.html'
	
	vFullGroup.extend

		render: ->
			vFullGroup.prototype.render.apply @

			rtpl = _.template tpl, @model.toJSON()
			@$('.group-body').html rtpl

			#rOrganisations = new vSmallList 'collection': @model.get('organisations')
			#@$('.organisations').html rOrganisations.render().$el