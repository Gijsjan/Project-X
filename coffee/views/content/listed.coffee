define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	ListedTemplates = require 'switchers/templates.listed'
	tplListedContent = require 'text!../../../templates/content/listed'

	Backbone.View.extend
		render: ->
			@$el.html _.template tplListedContent, type: @model.get('type')

			tpl =  ListedTemplates[@model.get('type')]
			tplRendered = _.template tpl, @model.toJSON()

			@$('.content-main').html tplRendered

			@

