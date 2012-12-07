BaseCollection = require './base'
mDepartment = require '../models/department'

class Department extends BaseCollection
	
	'model': mDepartment

module.exports = Department