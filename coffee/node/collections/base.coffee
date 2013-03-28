_ = require 'lodash'
Backbone = require 'backbone'
db = require('../MySQLConnection')

class BaseCollection extends Backbone.Collection

	initialize: ->
		console.log 'BaseCollection.initialize: @model empty or unknown!' if _.isEmpty @model or not @model?
		console.log @model if _.isEmpty @model or not @model?

		m = new @model
		@type = m.type

	fetchOptions: ->
		'tables': @type

	fetch: (callback, options) ->
		options = @fetchOptions() if not options?

		super
			'fetchOptions': options
			success: (collection, response, options) =>
				callback
					'code': options.code
					'data': collection.toJSON()
			error: (collection, xhr, options) => console.log xhr

	fetchOne2Many: (args) ->
		[model, callback] = [args.model, args.callback]

		@fetch callback,
			'tables': @type
			'where': '`'+model.type+"_id` = '"+model.id+"'"
	
	###*
	* Fetches models that are in a many-to-many relationship with a given model.
	*
	* Local vars:
	* 	one_model is passed as args.model and is the model which requests related models
	* 	many_model is the model of this collection and the blueprint for the models-to-be-fetched
	* 	fetchOptions is redefined and passed to @fetch
	* 
	* Args:
	* 	args.model is the model which requests related models
	* 	args.callback is the callback called after models are fetched
	*
	* @param {Object} args one_model, callback
	###
	fetchMany2Many: (args) ->
		[one_model, callback] = [args.model, args.callback]
		many_model = new @model()

		# Build relation_table
		one_table = if one_model.isContent() then 'content' else one_model.type
		many_table = if many_model.isContent() then 'content' else many_model.type
		relation_table = if many_table > one_table then one_table+'__'+many_table else many_table+'__'+one_table

		fetchOptions =
			'tables': [many_table, relation_table]
			'fields': ['`'+many_table+'`.*']
			'where': "`"+relation_table+"`."+many_table+"_id = `"+many_table+"`.id 
						AND `"+relation_table+"`."+one_table+"_id = '"+one_model.id+"'"

		if many_model.has(many_table+'_type')
			fetchOptions.tables.push many_table + '_type'
			fetchOptions.fields.push '`'+many_table+'_type`.value as type_value'
			fetchOptions.where += " AND `"+many_table+"_type`.id = `"+many_table+"`.type_id"

		if relation_table is 'content__group' or relation_table is 'content__person'
			fetchOptions.fields.push '`'+relation_table+'`.access'

		@fetch callback, fetchOptions

	sync: (method, collection, options) ->
		[fetchOptions, success, error] = [options.fetchOptions, options.success, options.error]

		if method is 'read'

			db.select fetchOptions, (response) ->
				if response.code is 200
					options.code = response.code
					success collection, response.data, options
				else
					error collection, response, options

module.exports = BaseCollection