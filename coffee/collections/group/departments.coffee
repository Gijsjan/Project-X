define (require) ->
	BaseCollection = require 'collections/base'
	mDepartment = require 'models/group/department'

	class cDepartments extends BaseCollection

		model: mDepartment
	
		url: '/b/db/departments'