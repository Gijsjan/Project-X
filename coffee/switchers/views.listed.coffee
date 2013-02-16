define (require) ->
	# OBJECT
	vPerson = require 'views/person/listed'

	# CONTENT
	Content = require 'views/content/listed'
	vNote = require 'views/content/note/listed'
	# vEvent = require 'views/object/content/event/listed'
	# vLink = require 'views/object/content/link/listed'
	# vVideo = require 'views/object/content/video/listed'
	# vDocument = require 'views/object/content/document/listed'
	# vFormat = require 'views/object/content/format/listed'

	# # GROUPS
	vGroup = require 'views/group/listed'
	vDepartment = require 'views/group/department/listed'
	vOrganisation = require 'views/group/organisation/listed'
	# vOrganisation = require 'views/object/group/organisation/listed'
	# vProject = require 'views/object/group/project/listed'

	'content': Content
	'person': vPerson

	'note': vNote
	
	'group': vGroup
	'departments': vDepartment
	'organisations': vOrganisation
	# 'content/event': vEvent
	# 'content/link': vLink
	# 'content/video': vVideo
	# 'content/document': vDocument
	# 'content/format': vFormat

	# 'group/organisation': vOrganisation
	# 'group/project': vProject
