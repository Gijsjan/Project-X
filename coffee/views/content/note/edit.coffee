define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'
	# Markdown = require 'markdown'
	vEdit = require 'views/edit'
	tpl = require 'text!html/content/note/edit.html'

	class vEditNote extends vEdit