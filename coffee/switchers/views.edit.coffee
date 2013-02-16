define (require) ->
	# OBJECT
	vPerson = require 'views/person/edit'

	# CONTENT
	Content = require 'views/content/edit'
	vNote = require 'views/content/note/edit'
	# vEvent = require 'views/object/content/event/edit'
	# vLink = require 'views/object/content/link/edit'
	# vVideo = require 'views/object/content/video/edit'
	# vDocument = require 'views/object/content/document/edit'
	# vFormat = require 'views/object/content/format/edit'

	# # GROUPS
	vGroup = require 'views/group/edit'
	vDepartment = require 'views/group/department/edit'
	vOrganisation = require 'views/group/organisation/edit'
	# vOrganisation = require 'views/object/group/organisation/edit'
	# vProject = require 'views/object/group/project/edit'

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
