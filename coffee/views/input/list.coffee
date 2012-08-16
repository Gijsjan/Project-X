# @option.model_type = name of the models (departements, users) to make the call to the api
# ??? @options.initValue if a value has already been entered (on edit)

define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	cResult = require 'collections/ac.result'
	tpl = require 'text!html/input/list.html'
	hlpr = require 'helper'

	class vInputList extends BaseView

		className: 'input-list'

		### EVENTS ###

		events:
			'keyup input.ac': 'onKeyup'
			'mouseenter .ac-option': 'onHoverOption' 
			'mouseleave .ac-option': 'onHoverOption'
			'click .ac-option': 'onClickOption'

		onKeyup: (e) ->
			if e.keyCode is 40 or e.keyCode is 38 # down or up arrow
				@result.highlightNext() if e.keyCode is 40
				@result.highlightPrev() if e.keyCode is 38
			else if e.keyCode is 13 # enter
				@trigger 'done', @result.highlighted

		onHoverOption: (e) ->
			@result.highlightByID(e.currentTarget.dataset.id)

		onClickOption: (e) ->
			@trigger 'done', @result.highlighted

		### /EVENTS ###

		initialize: ->
			@view = @options.view # ie: departements, users

			@result = new cResult
				'view': @view
			@result.on 'model highlighted', (id) =>
				@$('.highlight').removeClass 'highlight'
				@$('div.ac-option[data-id='+id+']').addClass('highlight')

			@result.fetch
				success: (collection, response) =>
					@result.reset response.rows
					@render()
				error: (collection, response) =>
					@navigate 'login' if response.status is 401

			super


		render: ->
			@$el.html _.template tpl, 'collection': @result

			@$('input.ac').focus()

			@trigger 'rendering finished'

			@