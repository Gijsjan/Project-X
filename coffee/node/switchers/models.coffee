Content = require '../models/content'
Group = require '../models/group'
Person = require '../models/person'

Note = require '../models/content/note'

Department = require '../models/groups/department'
Organisation = require '../models/groups/organisation'
Project = require '../models/groups/project'

Owner = require '../models/people/owner'
Editor = require '../models/people/editor'
Reader = require '../models/people/reader'
Member = require '../models/people/member'

Comment = require '../models/annotations/comment'

ModelSwitcher =
	'content': Content
	'groups': Group
	'people': Person

	'notes': Note
	
	'departments': Department
	'organisations': Organisation
	'projects': Project

	'owners': Owner
	'editors': Editor
	'readers': Reader
	'members': Member
	
	'comments': Comment

module.exports = ModelSwitcher