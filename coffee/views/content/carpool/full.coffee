define (require) ->
	ContentFull = require 'views/content/full'
	vTrips = require 'views/content/carpool/trip/list'
	tpl = require 'text!html/content/carpool/full.html'

	class Carpool extends ContentFull

		render: ->
			super

			tplr = _.template tpl, @model.toJSON()
			@$('.content-body').html tplr

			@