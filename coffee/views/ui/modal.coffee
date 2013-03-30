define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/ui/modal.html'

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

		show: ->
			@$('.modal').modal('show')

		hide: ->
			@$('.modal').modal('hide')