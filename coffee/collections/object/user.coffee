define (require) ->
	BaseCollection = require 'collections/base'
	mPerson = require 'models/object/user'

	class cPeople extends BaseCollection

		model: mPerson
	
		url: '/b/db/people'