_ = require 'lodash'
Backbone = require 'backbone'
exec = require('child_process').exec
db = require('../MySQLConnection')
# nutteloos
class Base extends Backbone.Model

	defaults: ->
		'created': ''
		'updated': ''

	### FETCH ###

	fetchOptions: ->
		'tables': @type
		'where': "`"+@type+"`.id = '"+@id+"'"

	fetch: (cb, options) ->
		options = @fetchOptions() if not options?

		super
			'fetchOptions': options
			success: (model, response, options) =>
				@afterFetch =>
					cb
						'code': options.code
						'data': @attributes
			error: (model, xhr, options) -> console.log '[Error] BaseModel.fetch' + xhr

	afterFetch: (cb) -> cb()

	### /FETCH ###

	### SAVE ###

	beforeSave: (cb) -> cb @attributes

	save: (cb) ->
		super [],
			success: (model, response, options) =>
				@afterSave =>
					cb 
						'code': options.code
						'data': @attributes
			error: (model, response, options) -> cb 'code': response.code

	afterSave: (cb) -> cb()

	### /SAVE ###

	destroy: (cb) ->
		super
			success: (model, response, options) -> cb response
			error: (model, response, options) -> cb 'code': response.code
	
	sync: (method, model, options) ->
		{fetchOptions, success, error} = options

		save = =>
			@beforeSave (attributes) =>
				db.save @type, attributes, (response) =>
					options.code = response.code
					
					if response.code is 200 or response.code is 201
						attributes.id = response.data if response.code is 201
						success attributes
					else
						error {}

		switch method

			when 'read'

				db.select fetchOptions, (response) =>
					options.code = response.code
					
					if response.code is 200
						success response.data[0]
					else
						error {}

			when 'create'

				@set 'created', @_getDate()

				save()

			when 'update'

				@set 'updated', @_getDate()

				save()

			when 'delete'

				db.destroy @type, @id, (response) -> success response


	isContent: ->
		content = false
		list = @_listInheritance()
		
		if list.indexOf('Content') > 0 or list.indexOf('ContentFull') > 0 or list.indexOf('ContentMin') > 0
			content = true 

		content

	
	_listInheritance: ->
		obj = @constructor			
		classes = [obj.name]

		while obj.__super__?
			classes.push obj.__super__.constructor.name
			obj = obj.__super__.constructor

		classes

	_getDate: ->
		date = new Date()
		date.getUTCFullYear() + '-' + ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' + date.getUTCDate() + ' ' + ('00' + date.getUTCHours()).slice(-2) + ':' + ('00' + date.getUTCMinutes()).slice(-2) + ':' + ('00' + date.getUTCSeconds()).slice(-2)
			
module.exports = Base