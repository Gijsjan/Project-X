define (require) ->
	# OBJECTS
	vUser = require 'views/object/user/edit'
	vComment = require 'views/object/comment/edit'

	# CONTENT
	vEvent = require 'views/object/content/event/edit'
	vLink = require 'views/object/content/link/edit'
	vVideo = require 'views/object/content/video/edit'
	vDocument = require 'views/object/content/document/edit'
	vNote = require 'views/object/content/note/edit'
	vFormat = require 'views/object/content/format/edit'
	
	# GROUPS
	vDepartement = require 'views/object/group/departement/edit'
	vOrganisation = require 'views/object/group/organisation/edit'
	vProject = require 'views/object/group/project/edit'

	'user': vUser
	'comment': vComment

	'event': vEvent
	'link': vLink
	'video': vVideo
	'document': vDocument
	'note': vNote
	'format': vFormat
	
	'departement': vDepartement
	'organisation': vOrganisation
	'project': vProject