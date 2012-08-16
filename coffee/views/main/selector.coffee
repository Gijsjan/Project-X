define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!html/main/selector.html'

	Backbone.View.extend
		className: 'selector'
		events:
			"change ul li input": "onContentSelected"
		onContentSelected: (e) ->
			target = $(e.currentTarget)
			id = target.attr 'id'
			if target.prop 'checked'
				@checkboxes.push id
			else
				@checkboxes.splice @checkboxes.indexOf(id), 1
			@trigger 'checkboxChecked'
		
		initialize: ->
			@labelInfo = new Backbone.Collection()
			@labelInfo.comparator = (model) ->
				-model.get 'active'
			@checkboxes = []
		render: ->
			@$el.html _.template tpl, 
				'title': @options.title
				'labels': @labelInfo.sort()

			_.each @checkboxes, (checkbox) =>
				checkbox = checkbox.replace /(:|\.)/g,'\\$1' # necessary for dots in labels (ie: backbone.js, require.js, etc)
				@$('input#'+checkbox).prop('checked', true) # set checked to true of the checkboxes that are listed in the @checkboxes array

			@
		updateLabelInfo: (name, active) ->
			index = @labelInfo.pluck('name').indexOf(name)

			if index isnt -1
				model = @labelInfo.at(index)

				if active	
					active_count = model.get('active')
					model.set('active', active_count + 1)
				
				inactive_count = model.get('inactive')
				model.set('inactive', inactive_count + 1)
			else
				model = 
					name: name
					inactive: 1

				model.active = if active then 1 else 0

				@labelInfo.add model