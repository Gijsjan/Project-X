define (require) ->
	BaseCollection = require 'collections/base'
	mPerson = require 'models/person.min'

	class People extends BaseCollection

		model: mPerson
	
		url: '/b/db/person'