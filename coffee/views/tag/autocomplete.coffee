define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	tpl = require 'text!templates/tag/list.html' #UNUSED?

	Backbone.View.extend
		id: 'ac-tag-list'
		initialize: ->
			@parent = @options.parent;
			@fetchedTagLists = {}
			@selected = false;
		render: (tags) ->
			@close()
			
			_.each tags, (tag) =>
				@$el.append $('<div />', 
					'class': 'ac-tag'
					'text': tag.slug)

			@
		close: ->
			@$el.html ''
			@selected = false
		onEnter: ->
			v = @parent.inputValue
			v = @$('.selected').text() if @selected is true
			@parent.addTag v
		onUp: ->
			s = @$('.selected');
			first = @$('.ac-tag:first');
			last = @$('.ac-tag:last');
			@selected = true;
			
			if s.length is 0
				last.addClass 'selected'
			else
				s.removeClass 'selected'
				if first.text() is s.text()
					last.addClass 'selected'
				else 
					s.prev().addClass 'selected'
		onDown: ->
			s = @$('.selected')
			first = @$('.ac-tag:first')
			last = @$('.ac-tag:last')
			@selected = true
			
			if s.length is 0
				first.addClass('selected')
			else
				s.removeClass('selected')
				if last.text() is s.text()
					first.addClass 'selected'
				else 
					s.next().addClass 'selected'
		getTagList: ->
			iv = @parent.inputValue
			
			if @fetchedTagLists[iv]?
				$.getJSON('/api/ac_tags/'+iv, (tags) =>
					@fetchedTagLists[iv] = tags
					@render tags
				).error((response) =>
					@navigate 'login' if response.status is 401
				)
			else
				@render @fetchedTagLists[iv]