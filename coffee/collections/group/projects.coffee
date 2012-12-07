define (require) ->
	BaseCollection = require 'collections/base'
	mProject = require 'models/group/project'

	class cProjects extends BaseCollection

		model: mProject
	
		url: '/b/db/projects'