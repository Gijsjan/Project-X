define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'
	hlpr = require 'helper'

	class mListItem extends Backbone.Model

		'defaults':
			'id': '' # name
			'title': '' # slug