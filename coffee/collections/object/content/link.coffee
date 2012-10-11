define (require) ->
	mLink = require 'models/object/content/link'
	cContent = require 'collections/object/content/content'

	class cLink extends cContent

		model: mLink
	
		url: '/db/projectx/_design/content/_view/links'