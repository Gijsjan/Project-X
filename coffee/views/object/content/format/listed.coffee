define (require) ->
	_ = require 'underscore'
	vListedContent = require 'views/object/content/listed'
	tpl = require 'text!html/format/listed.html'
	hlpr = require 'helper'

	class vListedFormat extends vListedContent
		events: ->
			'click p[data-key=description]': 'toggleDescription'

		toggleDescription: (e) ->
			if $(e.currentTarget).hasClass('partial') 	then @$('p[data-key=description]').attr('class', 'full').html @model.get('description')
			else if $(e.currentTarget).hasClass('full') then @$('p[data-key=description]').attr('class', 'partial').html hlpr.partial(@model.get('description'), 100)

		render: ->
			super

			rtpl = _.template tpl, @model.toJSON()
			@$('.content-body').html rtpl

			@$('p[data-key=description]').attr('class', 'partial').html hlpr.partial(@model.get('description'), 120)

			@