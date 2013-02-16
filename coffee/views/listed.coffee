define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/listed.html'

	class vListed extends BaseView

		render: ->
			data = @model.toJSON()
			data.type = @model.type

			tplRendered = _.template tpl, data
			@$el.html tplRendered

			@