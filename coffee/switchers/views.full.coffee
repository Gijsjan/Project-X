define (require) ->
	# OBJECT
	vPerson = require 'views/person/full'

	# CONTENT
	Content = require 'views/content/full'
	vNote = require 'views/content/note/full'
	# vEvent = require 'views/object/content/event/full'
	# vLink = require 'views/object/content/link/full'
	# vVideo = require 'views/object/content/video/full'
	# vDocument = require 'views/object/content/document/full'
	# vFormat = require 'views/object/content/format/full'

	# # GROUPS
	vGroup = require 'views/group/full'
	vDepartment = require 'views/group/department/full'
	vOrganisation = require 'views/group/organisation/full'
	# vOrganisation = require 'views/object/group/organisation/full'
	# vProject = require 'views/object/group/project/full'

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
