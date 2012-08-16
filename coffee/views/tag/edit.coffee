define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	vEditTagList = require 'views/tag/editlist'
	vAutocompleteTags = require 'views/tag/autocomplete'
	tplEditTags = require 'text!html/tag/edit.html'

	Backbone.View.extend
		id: 'edit-tags'
		events:
			"keyup input#add-tag": "onKeyup"
			"blur input#add-tag": "closeAC"
			
		initialize: () ->
			@inputValue = ''

			@tags = @model.get 'newtags' 
			@edit_tag_list = new vEditTagList
				'parent': @
				'collection': @tags
			@tags.bind "add", @edit_tag_list.render, @edit_tag_list
			@tags.bind "remove", @edit_tag_list.render, @edit_tag_list
			
			@ac_tags = new vAutocompleteTags
				'parent': @

		render: ->
			@$el.html _.template(tplEditTags)
			
			@$('#edit-tag-list-wrapper').html @edit_tag_list.render().$el
			
			@$('#autocomplete-wrapper').html @ac_tags.render().$el
			
			@
		closeAC: ->
			@ac_tags.close()

		onKeyup: (e) ->
			v = e.target.value
			kc = e.keyCode
			
			switch kc
				when 188 then @addTag v #comma
				when 40 then @ac_tags.onDown()
				when 38 then @ac_tags.onUp()
				when 13 then @ac_tags.onEnter()
				when 27 then @closeAC() #escape
				else
					if v.length > 1 and @inputValue isnt v
						@inputValue = v
						@ac_tags.getTagList()
		clearInput: ->
			@$('input#add-tag').val ''
		addTag: (value) ->
			tag = $.trim(value) #trim whitespaces
			if tag.indexOf(',') > 0 
				tag = tag.slice 0, tag.indexOf ',' #remove trailing comma
			
			if tag.length > 1
				ftl = @ac_tags.fetchedTagLists[@inputValue] # get last used taglists from AutocompleteView using the inputValue
				tag_obj = _.find ftl, (obj) -> 
					obj.slug.toLowerCase() is tag.toLowerCase() # check if tag is in used taglists
				if not tag_obj #if not, make new tag object
					tag_obj = 
						'slug': tag
						'type': 'tag'

				@tags.add tag_obj

			@closeAC()
			@clearInput()
		deleteTag: (e) ->
			text = $(e.target.parentElement).text().slice(0, -2) # remove space and 'x' => image instead?
			t = @tags.find (tag) -> 
				tag.get('slug') is text # find the model of the tag to remove

			if t
				@tags.remove t
			
			@closeAC()