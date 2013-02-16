_ = require 'underscore'
Backbone = require 'backbone'
riak = require '../riak'
CallbackQueue = require '../CallbackQueue'
exec = require('child_process').exec
db = require('../MySQLConnection')

class Base extends Backbone.Model

	'defaults':
		'created': ''
		'updated': ''

	fetchOptions: ->
		'tables': @type
		'where': "`"+@type+"`.id = '"+@id+"'"

	fetch: (callback, options) ->
		options = @fetchOptions() if not options?

		super
			'fetchOptions': options
			success: (model, response, options) ->
				callback
					'code': options.code
					'data': response
			error: (model, xhr, options) -> console.log xhr

	# Called after a fetch is complete in @sync()
	# NOP in Base, overriden in children
	# Replaces @parse()
	afterFetch: (args) -> args.callback args.attributes

	beforeSave: (callback) -> callback @attributes

	save: (callback) ->
		super [],
			success: (model, response, options) ->
				callback 
					'code': options.code
					'data': response
			error: (model, response, options) -> callback 'code': response.code


	afterSave: (callback) -> callback @attributes

	destroy: (callback) ->
		super
			success: (model, response, options) -> callback response
			error: (model, response, options) -> callback 'code': response.code
	
	sync: (method, model, options) ->
		[fetchOptions, success, error] = [options.fetchOptions, options.success, options.error]

		save = =>
			@beforeSave (attributes) =>
				db.save @type, attributes, (response) =>
					if response.code is 200 or response.code is 201
						@afterSave (attributes) ->
							options.code = response.code
							attributes.id = response.data if response.code is 201
							success model, attributes, options
					else
						error model, response, options

		switch method

			when 'read'

				fetchOptions.callback = (response) =>

					if response.code is 200
						@afterFetch
							'attributes': response.data[0]
							callback: (data) -> 
								options.code = response.code
								success model, data, options
					else
						error model, response, options

				db.select fetchOptions

			when 'create'

				@set 'created', @_getDate()

				save()

			when 'update'

				@set 'updated', @_getDate()

				save()

			when 'delete'

				db.destroy @type, @id, (response) -> success model, response, options

	_getDate: ->
		date = new Date()
		date.getUTCFullYear() + '-' + ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' + date.getUTCDate() + ' ' + ('00' + date.getUTCHours()).slice(-2) + ':' + ('00' + date.getUTCMinutes()).slice(-2) + ':' + ('00' + date.getUTCSeconds()).slice(-2)


module.exports = Base




	# loadOptions: -> {}
	
	# load: (id, callback) ->
	# 	defaultOptions =
	# 		'tables': @type
	# 		'where': "`"+@type+"`.`id` = '"+id+"'"
	# 		'callback': callback

	# 	options = _.extend defaultOptions, @loadOptions(id, callback)

	# 	db.select options



	# Is usually overridden by child models, but if not, the function returns the attributes as is.
	# Called in @save()
	# beforeSave: (callback) -> callback @attributes
	
	# save: (callback) ->
	# 	if @isNew() then @set 'created', @_getDate() else @set 'updated', @_getDate()

	# 	@beforeSave (attributes) =>
	# 		if @isNew()
	# 			db.insert @type, attributes, (response) =>
	# 				response.data = @attributes if response.code is 200

	# 				callback response
	# 		else
	# 			db.update @type, attributes, callback
	
	# afterSave: ->