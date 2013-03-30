define (require) ->
	Views =
		ContentFull: require 'views/content/full'
		TripList: require 'views/content/carpool/trip/list'
	Templates =
		tpl: require 'text!html/content/carpool/full.html'

	class Carpool extends Views.ContentFull

		render: ->
			super

			tplr = _.template Templates.tl, @model.toJSON()
			@$('.content-body').html tplr

			@