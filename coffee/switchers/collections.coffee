define (require) ->
	#OBJECTS
	# cTag = require 'collections/object/tag'
	# cComment = require 'collections/object/comment'
	# CONTENT
	# cEvent = require 'collections/object/content/event'
	# cLink = require 'collections/object/content/link'
	# cVideo = require 'collections/object/content/video'
	# cDocument = require 'collections/object/content/document'
	cPeople = require 'collections/people'
	
	cNotes = require 'collections/content/notes'
	# cFormat = require 'collections/object/content/format'
	# GROUPS
	cProjects = require 'collections/group/projects'
	cDepartments = require 'collections/group/departments'
	cOrganisations = require 'collections/group/organisations'

	'people': cPeople
	'notes': cNotes
	'projects': cProjects
	'departments': cDepartments
	'organisations': cOrganisations