define (require) ->
	Backbone = require 'backbone'
	BaseView = require 'views/base'
	ev = require 'EventDispatcher'
	vInputTable = require 'views/input/table'
	Input = require 'views/input/input'
	sEditTemplates = require 'switchers/templates.edit'
	FormConfig = require 'switchers/formconfigs'
	ajax = require 'AjaxManager'
	hlpr = require 'helper'

	class vEdit extends BaseView
		
		'events':
			"click button.save": "saveObject"

		saveObject: (e) ->
			# console.log 'vEdit.saveObject()'
			@model.save()
			false
		
		initialize: ->
			super

			if @model.isNew()
				@render() 
			else
				# PUT MODEL FETCH IN MODEL WITH A CALLBACK ARGUMENT ?
				@model.fetch
					success: (model, response, options) => @render()
					error: (model, xhr, options) => ev.trigger xhr.status+''


		render: ->
			# console.log 'vEditObject.render()'
			# data = @model.toJSON()
			# data.type = @model.type
			# data.id = @model.get('username') if data.type is 'person'
			
			tpl = sEditTemplates[@model.type]
			html = _.template tpl, @model.toJSON()
			@$el.html html

			for own key, options of FormConfig[@model.type]				
				options.key = key
				options.value = @model.get key
				input = new Input options
				input.on 'valuechanged', (key, value) => @model.set key, value

				@$('section.'+key).html input.$el
			
			hlpr.delay 0, @adjustTextareas # add delay of 0 to queue the adjusting, see: http://stackoverflow.com/questions/9502774/backbone-js-trigger-an-event-on-a-view-after-the-render

			@

		adjustTextareas: ->
			_.each @$('.tab-pane.active textarea'), (textarea) ->
				$(textarea).height textarea.scrollHeight # set the proper heights for textarea's