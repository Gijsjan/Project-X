define (require) ->
	cObject = require 'collections/object/object'

	cObject.extend

		url: '/api/content'

		comparator: (model) ->
			m = parseInt model.get('created').replace(/[- :]/g, "") # remove -, space and : from datetime string and convert to number (is conversion necessary?)
			#m = 1 if !model.get('show')
			return [!model.show, -m] # return negated number