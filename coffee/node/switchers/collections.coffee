Annotation = require '../collections/annotation'
Content = require '../collections/content'
Group = require '../collections/group'
Person = require '../collections/person'

Comment = require '../collections/annotations/comment'

Note = require '../collections/content/note'

Department = require '../collections/groups/department'
Organisation = require '../collections/groups/organisation'
Project = require '../collections/groups/project'

Owner = require '../collections/people/owner'
Editor = require '../collections/people/editor'
Reader = require '../collections/people/reader'
Member = require '../collections/people/member'


CollectionSwitcher =
	'annotations': Annotation
	'content': Content
	'person': Person
	
	'comments': Comment

	'note': Note
	
	'group': Group
	'departments': Department
	'organisations': Organisation
	'projects': Project

	'owners': Owner
	'editors': Editor
	'readers': Reader
	'members': Member
	

module.exports = CollectionSwitcher