define (require) ->
	# _ = require 'underscore'
	vListed = require 'views/listed'
	tpl = require 'text!html/group/department/listed.html'

	class vListedDepartment extends vListed
		
		render: ->
			super

			rtpl = _.template tpl, @model.toJSON()
			@$('.listed-body').html rtpl

			@