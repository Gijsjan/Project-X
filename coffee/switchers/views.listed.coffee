define (require) ->
	# OBJECT
	vPerson = require 'views/person/listed'

	# CONTENT
	vNote = require 'views/content/note/listed'
	# vEvent = require 'views/object/content/event/listed'
	# vLink = require 'views/object/content/link/listed'
	# vVideo = require 'views/object/content/video/listed'
	# vDocument = require 'views/object/content/document/listed'
	# vFormat = require 'views/object/content/format/listed'

	# # GROUPS
	vDepartment = require 'views/group/department/listed'
	vOrganisation = require 'views/group/organisation/listed'
	# vOrganisation = require 'views/object/group/organisation/listed'
	# vProject = require 'views/object/group/project/listed'

	'people': vPerson

	'notes': vNote
	
	'departments': vDepartment
	'organisations': vOrganisation
	# 'content/event': vEvent
	# 'content/link': vLink
	# 'content/video': vVideo
	# 'content/document': vDocument
	# 'content/format': vFormat

	# 'group/organisation': vOrganisation
	# 'group/project': vProject
