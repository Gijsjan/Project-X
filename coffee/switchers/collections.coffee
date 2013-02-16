define (require) ->
	#OBJECTS
	# cTag = require 'collections/object/tag'
	# cComment = require 'collections/object/comment'
	# CONTENT
	# cEvent = require 'collections/object/content/event'
	# cLink = require 'collections/object/content/link'
	# cVideo = require 'collections/object/content/video'
	# cDocument = require 'collections/object/content/document'
	Content = require 'collections/content'
	cPeople = require 'collections/people'
	
	cNotes = require 'collections/content/notes'
	# cFormat = require 'collections/object/content/format'
	# GROUPS
	Group = require 'collections/group'
	cProjects = require 'collections/group/projects'
	cDepartments = require 'collections/group/departments'
	cOrganisations = require 'collections/group/organisations'

	'content': Content
	'person': cPeople
	'note': cNotes
	'group': Group
	'projects': cProjects
	'departments': cDepartments
	'organisations': cOrganisations