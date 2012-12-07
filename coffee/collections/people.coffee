define (require) ->
	BaseCollection = require 'collections/base'
	mPerson = require 'models/person'

	class cPeople extends BaseCollection

		model: mPerson
	
		url: '/b/db/people'