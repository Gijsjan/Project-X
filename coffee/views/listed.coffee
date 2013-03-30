define (require) ->
	BaseView = require 'views/base'
	tpl = require 'text!html/listed.html'

	class vListed extends BaseView

		render: ->
			data = @model.toJSON()

			if @model.isContent() # CHANGE TO CONTENT & GROUP, NOT ONLY CONTENT
				edit = '/'+@model.get('type')+'/'+@model.get('content_type').value+'/'+@model.id+'/edit'
				full = '/'+@model.get('type')+'/'+@model.get('content_type').value+'/'+@model.id
			else
				edit = '/'+@model.get('type')+'/'+@model.id+'/edit'
				full = '/'+@model.get('type')+'/'+@model.id
			
			data.urls =
				'edit':	edit
				'full': full

			tplRendered = _.template tpl, data
			@$el.html tplRendered

			@