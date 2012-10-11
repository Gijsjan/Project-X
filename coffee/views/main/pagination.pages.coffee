define (require) ->
	_ = require 'underscore'
	tpl = require 'text!html/main/pagination.pages.html'
	hlpr = require 'helper'

	class PagesPagination extends Backbone.View

		initialize: ->
			@parent = @options.parent

			@pageTitles = []
			@pageSlugs = []
			
			_.each @parent.$el.find('.tab-pane'), (el) =>
				title = $(el).attr('data-title')

				@pageSlugs.push hlpr.slugify(title)
				@pageTitles.push title
			
			window.onhashchange = (e) =>
				@setTab()

			@render()

		render: ->
			@$el.html _.template tpl,
				'pageTitles': @pageTitles
				'pageSlugs': @pageSlugs

			@setTab()

			@$('a[data-toggle="tab"]').on 'shown', (e) => @trigger 'tabshown'

			@

		setTab: ->
			index = @pageSlugs.indexOf window.location.hash.slice(1)

			if index isnt -1 then @$('#myTab li:eq('+index+') a').tab('show')
			else @$('#myTab a:first').tab('show')