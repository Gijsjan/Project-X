define (require) ->
	# OBJECTS
	vComment = require 'views/object/comment/full'
	vUser = require 'views/object/user/full'

	# CONTENT
	vEvent = require 'views/object/content/event/full'
	vLink = require 'views/object/content/link/full'
	vVideo = require 'views/object/content/video/full'
	vDocument = require 'views/object/content/document/full'
	vNote = require 'views/object/content/note/full'
	vFormat = require 'views/object/content/format/full'
	
	# GROUPS
	vDepartement = require 'views/object/group/departement/full'
	vOrganisation = require 'views/object/group/organisation/full'
	vProject = require 'views/object/group/project/full'

	'comment': vComment
	'user': vUser

	'event': vEvent
	'link': vLink
	'video': vVideo
	'document': vDocument
	'note': vNote
	'format': vFormat

	'departement': vDepartement
	'organisation': vOrganisation
	'project': vProject