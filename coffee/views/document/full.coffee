define [
		'backbone'
		'views/content/full'
	], (Backbone, vFullContent) ->
		vFullContent.extend
			render: ->
				vFullContent.prototype.render.apply @
				@