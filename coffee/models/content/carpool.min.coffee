define (require) ->
	ContentFull = require 'models/content.full'

	class CarpoolMin extends ContentFull
		
		'type': 'carpool'

		defaults: -> 
			_.extend {}, ContentFull::defaults(),
				'model': ''
				'numberplate': ''
				'initial_mileage': ''

		initialize: ->
			@on "change:model change:numberplate", @setTitle, @

			super

		setTitle: ->
			title = '[' + @get('numberplate') + '] ' + @get('model')
			@set 'title', title