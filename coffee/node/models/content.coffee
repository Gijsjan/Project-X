_ = require 'underscore'
Base = require './base'
user = require './people/user'

class Content extends Base
	
	'defaults': _.extend({}, Base::defaults, 
		'title': '')

	'relations':
		'owners': 
			'storetype': 'attached'
			'data': []
		'editors': 
			'storetype': 'attached'
			'data': []
		'readers': 
			'storetype': 'attached'
			'data': []
		'organisations': 
			'storetype': 'attached'
			'data': []
		'departments': 
			'storetype': 'attached'
			'data': []
		'comments': 
			'storetype': 'separate'
			'data': []
		'projects': 
			'storetype': 'attached'
			'data': []

	initialize: ->
		if @isNew()
			@relations.owners.data.push user.getRelationAttributes()

		super


module.exports = Content