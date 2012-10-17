define (require) ->
	BaseView = require 'views/base'
	cResult = require 'collections/ac.result'
	vInputList = require 'views/input/list'
	tpl = require 'text!html/main/modal.html'
	hlpr = require 'helper'

	class vModal extends BaseView

		initialize: ->
			@view = @options.view
			@title = if @options.title? then @options.title else ''
			@render()

		render: ->
			rhtml = _.template tpl, 
				'title': @title
			@$el.html rhtml

			@$('.modal-body').html @view.$el

			@$('.modal').on 'hidden', => @remove()
			@$('.modal').on 'shown', => @view.trigger 'modalshown'

			@$('.modal').modal() # init modal

			$('body').append @$el