define (require) ->
	vListed = require 'views/listed'
	tpl = require 'text!html/group/organisation/listed.html'

	class vListedOrganisation extends vListed
		
		render: ->
			super

			rtpl = _.template tpl, @model.toJSON()
			@$('.listed-body').html rtpl

			@