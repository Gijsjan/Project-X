define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/listed.html'

	class vListed extends BaseView

		render: ->
			tplRendered = _.template tpl, @model.toJSON()
			@$el.html tplRendered

			@