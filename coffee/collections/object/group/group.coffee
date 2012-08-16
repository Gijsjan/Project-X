define (require) ->
	cObject = require 'collections/object/object'
	mGroup = require 'models/object/group/group'

	cObject.extend
		
		model: mGroup

		url: '/api/groups'

		comparator: (model) ->
			return [!model.show, model.get('title')]