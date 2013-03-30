define (require) ->
	# OBJECT
	vPerson = require 'views/person/edit'

	# CONTENT
	vNote = require 'views/content/note/edit'
	Carpool = require 'views/content/carpool/edit'
	# vEvent = require 'views/object/content/event/edit'
	# vLink = require 'views/object/content/link/edit'
	# vVideo = require 'views/object/content/video/edit'
	# vDocument = require 'views/object/content/document/edit'
	# vFormat = require 'views/object/content/format/edit'

	# # GROUPS
	vGroup = require 'views/group/edit'
	# vOrganisation = require 'views/object/group/organisation/edit'
	# vProject = require 'views/object/group/project/edit'

	'note': vNote
	'carpool': Carpool

	'person': vPerson
	
	'group': vGroup
	# 'content/event': vEvent
	# 'content/link': vLink
	# 'content/video': vVideo
	# 'content/document': vDocument
	# 'content/format': vFormat

	# 'group/organisation': vOrganisation
	# 'group/project': vProject
