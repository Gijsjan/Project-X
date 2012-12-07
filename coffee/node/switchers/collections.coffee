Department = require '../collections/department'
Organisation = require '../collections/organisation'
Person = require '../collections/person'
Note = require '../collections/content/note'

CollectionSwitcher =
	'departments': Department
	'organisations': Organisation
	'people': Person
	'notes': Note

module.exports = CollectionSwitcher