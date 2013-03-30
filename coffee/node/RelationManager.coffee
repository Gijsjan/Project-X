_ = require 'lodash'
async = require 'async'
db = require './MySQLConnection'
Collections = require './switchers/collections'

class RelationManager

	fetch: (model, cb) ->
		funcs = {}

		_.each model.relations(), (config, attribute) ->
			table = config.key

			funcs[table] = (callback) ->
				fn = if config.type is 'many2many' then 'fetchMany2Many' else 'fetchOne2Many'
				
				Collections.get(table)[fn]
					'model': model
					callback: (response) -> 
						callback null, response.data
		
		async.parallel funcs, (err, result) =>
			for own attribute, config of model.relations()
				model.set attribute, result[config.key]
			
			cb()


module.exports = new RelationManager()