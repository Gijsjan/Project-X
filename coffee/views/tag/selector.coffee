define (require) ->
	_ = require 'underscore'
	tpl = require 'text!templates/tag/selector.html'

	Backbone.View.extend
		id: 'tag-selector'
		tags: {}
		checkboxes: []
		events:
			"change ul li input": "onTagSelected"
		onTagSelected: (e) ->
			target = $(e.currentTarget)
			id = target.attr('id')
			if target.prop('checked')
				@checkboxes.push id
			else
				@checkboxes.splice(@checkboxes.indexOf(id), 1);
			
			@trigger 'checkboxChecked'
		initialize: ->
		render: ->
			#@updateTags()

			@$el.html _.template tpl, tags: @labelInfo

			$('#sidebar').append(@$el);

			_.each @checkboxes, (checkbox) =>
				checkbox = checkbox.replace(/(:|\.)/g,'\\$1');
				@$('input#'+checkbox).prop('checked', true)
			@
		updateLabelInfo: (slug, active) ->
			@labelInfo[slug] ?=
					'active': 0
					'inactive': 0

			if active
				@labelInfo[slug]['active'] = @labelInfo[slug]['active'] + 1
			@labelInfo[slug]['inactive'] = @labelInfo[slug]['inactive'] + 1
		###
		updateTags: ->
			@tags = {}

			@collection.each (model) =>
				model.get('newtags').each (tag) =>
					modeltags = tag.get('slug')
					if _.has(@tags, modeltags) 
						@tags[modeltags] = @tags[modeltags] + 1
					else 
						@tags[modeltags] = 1
		filterCollection: (collection, callback) ->
			removing = []

			_.each @checkboxes, (checkbox) ->
				collection.each (model) ->
					nomatch = true
					model.get('newtags').each (tag) =>
						if checkbox is tag.get('slug')
							nomatch = false
					removing.push model if nomatch

			collection.remove removing

			callback collection
		###