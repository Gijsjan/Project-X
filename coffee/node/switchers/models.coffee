Department = require '../models/department'
Organisation = require '../models/organisation'
Person = require '../models/person'
Note = require '../models/content/note'

ModelSwitcher =
	'departments': Department
	'organisations': Organisation
	'people': Person
	'notes': Note

module.exports = ModelSwitcher