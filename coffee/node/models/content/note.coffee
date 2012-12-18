_ = require 'underscore'
Content = require '../content'
# relationManager = require '../../RelationManager'

class Note extends Content

	# initialize: ->
	# 	console.log Content

	# 'defaults': console.log(Content)

	'defaults': _.extend({}, Content::defaults, 
		'type': 'notes'
		'body': '')

		# 'owners': 'attached'
		# 'editors': 'attached'
		# 'readers': 'attached'
		# 'departments': 'attached'
		# 'organisations': 'attached'
		# 'projects': 'attached'
		# 'comments': 'separate'

module.exports = Note