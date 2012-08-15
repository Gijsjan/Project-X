###
Creates a popup.

@options.parent represents the view from which the popup is called
@options.child represents the view which is rendered in the popup

The 'save succesful' event has to be dealt with in the parent.

The popup is rendered from the parent.
The child is rendered in the popup.

Example usage, in parent:

| chld = new vChild()
|
| popup = new vPopup
| 	parent: @
| 	child: chld
| 
| eu.on 'some event', (response) =>
| 	# code
| 
| popup.render()

###
define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'

	class vPopup extends BaseView

		id: 'popup'

		initialize: ->
			@parent = @options.parent
			@child = @options.child

			@child.on 'done', =>
				@close()

			setTimeout((=> @addClickEvent()), 500) # add timeout to skip the first click

			@render()

			super

		render: ->
			### THIS RENDER IS FIRED TWICE, WHY???? ###

			@$el.html @child.$el
			$('body').append @$el

			# center popup horizontally and vertically
			@$el.css 'left', (@screenwidth/2 - @$el.width()/2)
			@$el.css 'top', (@screenheight/2 - @$el.height()/2)

			$('#wrapper').animate opacity: 0.2, 400
			@$el.animate opacity: 1, 400

			@

		addClickEvent: ->
			$(document).on 'click', (e) =>
				container = $('#popup')
				@close() if container.has(e.target).length is 0

		close: ->
			$(document).off 'click'
			$('#wrapper').animate opacity: 1, 400
			@$el.animate opacity: 0, 400, =>
				@child.unregister()
				@unregister()

			