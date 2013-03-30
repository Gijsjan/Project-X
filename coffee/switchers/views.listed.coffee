define (require) ->
	# OBJECT
	vPerson = require 'views/person/listed'

	# CONTENT
	vNote = require 'views/content/note/listed'
	Carpool = require 'views/content/carpool/listed'
	CarpoolTrip = require 'views/content/carpool/trip/listed'
	# vEvent = require 'views/object/content/event/listed'
	# vLink = require 'views/object/content/link/listed'
	# vVideo = require 'views/object/content/video/listed'
	# vDocument = require 'views/object/content/document/listed'
	# vFormat = require 'views/object/content/format/listed'

	# # GROUPS
	vGroup = require 'views/group/listed'
	# vOrganisation = require 'views/object/group/organisation/listed'
	# vProject = require 'views/object/group/project/listed'

	'note': vNote
	'carpool': Carpool
	'carpool_trip': CarpoolTrip
	
	'person': vPerson

	'group': vGroup
	# 'departments': vDepartment
	# 'organisations': vOrganisation
	# 'content/event': vEvent
	# 'content/link': vLink
	# 'content/video': vVideo
	# 'content/document': vDocument
	# 'content/format': vFormat

	# 'group/organisation': vOrganisation
	# 'group/project': vProject
