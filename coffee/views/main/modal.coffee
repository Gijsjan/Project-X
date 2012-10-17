define (require) ->
	BaseView = require 'views/base'
	# cResult = require 'collections/ac.result'
	vInputList = require 'views/input/list'
	tpl = require 'text!html/main/modal.html'
	hlpr = require 'helper'

	class vModal extends BaseView

		initialize: ->
			@il = new vInputList
				'items': @options.items
			@il.on 'itemselected', (model) =>
				@trigger 'itemselected', model
				@$('.modal').modal('hide')

			@render()

		render: ->
			renderedHTML = _.template tpl,
				'title': 'Select from list'
			@$el.html renderedHTML

			@$('.modal-body').html @il.$el

			@$('.modal').on 'hidden', => @remove()
			@$('.modal').on 'shown', => @$('input').focus() # set focus on the input when modal is shown

			@$('.modal').modal() # init modal

			$('body').append @$el