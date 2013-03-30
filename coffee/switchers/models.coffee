define (require) ->
	#OBJECTS
	# cTag = require 'models/object/tag'
	# cComment = require 'models/object/comment'
	# CONTENT
	# cEvent = require 'models/object/content/event'
	# cLink = require 'models/object/content/link'
	# cVideo = require 'models/object/content/video'
	# cDocument = require 'models/object/content/document'
	Content = require 'models/content.full'
	Note = require 'models/content/note.full'
	Carpool = require 'models/content/carpool.full'
	
	Person = require 'models/person.full'
	Group = require 'models/group.full'
	
	# # cFormat = require 'models/object/content/format'
	# # GROUPS
	# cProjects = require 'models/group/projects'
	# cDepartments = require 'models/group/departments'
	# cOrganisations = require 'models/group/organisations'

	'content': Content
	'note': Note
	'carpool': Carpool
	
	'person': Person
	'group': Group
	# 'notes': cNotes
	# 'projects': cProjects
	# 'departments': cDepartments
	# 'organisations': cOrganisations