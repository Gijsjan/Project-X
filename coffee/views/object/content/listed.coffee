# define (require) ->
# 	_ = require 'underscore'
# 	vTagList = require 'views/tag/list'
# 	tpl = require 'text!html/content/listed.html'

# 	Backbone.View.extend

# 		render: ->
# 			tplRendered = _.template tpl, @model.toJSON()
# 			@$el.html tplRendered

# 			# tags = new vTagList
# 			# 	tags: @model.get 'tags'
# 			# @$('.tags-wrapper').html tags.render().$el

# 			@