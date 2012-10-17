define (require) ->
	_ = require 'underscore'
	vFullContent = require 'views/object/content/full'
	tpl = require 'text!html/format/full.html'

	class vFullFormat extends vFullContent

		render: ->
			super

			rtpl = _.template tpl, @model.toJSON()
			@$('.content-body').html rtpl

			@