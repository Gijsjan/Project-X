define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/content/settings.html'

	class vContentInfo extends BaseView

		className: 'settings'

		initialize: ->
			@model = @options.model
			@render()

			$.ajax
				'url': '/db/projectx/'+@model.id+'?revs=true'
				'dataType': 'json'
				'success': (data) =>
					console.log data
				error: (collection, response) => @globalEvents.trigger response.status+''

		render: ->
			rhtml = _.template tpl, @model.toJSON()
			@$el.html rhtml

			@