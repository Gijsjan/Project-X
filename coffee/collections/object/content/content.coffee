define (require) ->
	cObject = require 'collections/object/object'

	class cContent extends cObject

		comparator: (model) ->
			m = parseInt model.get('created').replace(/[- :]/g, "") # remove -, space and : from datetime string and convert to number (is conversion necessary?)
			#m = 1 if !model.get('show')
			return [!model.show, -m] # return negated number


		# Couchdb responds with {total_rows: 13, "rows": [{"id": "f02...df3", "value": {doc}, "key": "some title"}], "offset": 0}
		# To get the doc we need to pluck the value
		parse: (response) ->
			# console.log 'cContent.parse()'
			@collectionManager.register @url, response
			_.pluck(response.rows, 'value');
	
		# set: (attrs, options) ->
		# 	console.log 'cContent.set()'

		# 	super

		# fetch: (options) ->
		# 	console.log 'cContent.fetch()'

		# 	super