define (require) ->
	Models = require 'switchers/models'
	Collections = require 'switchers/collections'

	EditTemplates = require 'switchers/templates.edit'

	FullViews = require 'switchers/views.full'
	EditViews = require 'switchers/views.edit'
	ListedViews = require 'switchers/views.listed'

	'Models': Models
	'Collections': Collections
	'Templates':
		'Edit': EditTemplates
	'Views':
		'Full': FullViews
		'Edit': EditViews
		'Listed': ListedViews