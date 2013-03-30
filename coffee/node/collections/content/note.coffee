_ = require 'lodash'
Content = require '../content'
mNote = require '../../models/content/note'

class Note extends Content
	
	'model': mNote

	initialize: ->
		@model = require('../../models/content/note') if _.isEmpty @model

		super

module.exports = Note