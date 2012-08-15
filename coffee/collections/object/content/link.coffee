define (require) ->
	Backbone = require 'backbone'
	mLink = require 'models/object/content/link'

	class cLink extends Backbone.Collection

		model: mLink
	
		url: '/db/projectx/_design/content/_view/links'

		# Couchdb responds with {total_rows: 13, "rows": [{"id": "f02...df3", "key": {doc}, "value": null}], "offset": 0}
		# To get the doc we need to pluck the key
		parse: (response) ->
			# console.log 'parsing cLink'
			_.pluck(response.rows, 'key');