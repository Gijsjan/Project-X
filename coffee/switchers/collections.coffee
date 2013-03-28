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
	Notes = require 'collections/content/notes'
	Carpools = require 'collections/content/carpool'
	CarpoolTrips = require 'collections/content/carpool/trip'
	
	cPeople = require 'collections/people'
	
	Group = require 'collections/group'
	# cFormat = require 'collections/object/content/format'
	# GROUPS
	# cProjects = require 'collections/group/projects'
	# cDepartments = require 'collections/group/departments'
	# cOrganisations = require 'collections/group/organisations'

	'content': Content
	'note': Notes
	'carpool': Carpools
	'carpool_trip': CarpoolTrips

	'person': cPeople
	'group': Group
	# 'projects': cProjects
	# 'departments': cDepartments
	# 'organisations': cOrganisations