define (require) ->
	moment = require 'moment'
	Views =
		Base: require 'views/base'
	tpl = require 'text!html/content/carpool/trip/listed.html'

	class ListedTrip extends Views.Base
		render: ->
			data = @model.toJSON()
			data.date = moment(@model.get('datetime')).format("MMM Do 'YY")
			data.time = moment(@model.get('datetime')).format("H:mm")

			tplr = _.template tpl, data
			@$el.html tplr

			@