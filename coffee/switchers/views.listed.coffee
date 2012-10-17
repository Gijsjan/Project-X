define (require) ->
	# OBJECT
	vUser = require 'views/object/user/listed'

	# CONTENT
	vEvent = require 'views/object/content/event/listed'
	vLink = require 'views/object/content/link/listed'
	vVideo = require 'views/object/content/video/listed'
	vDocument = require 'views/object/content/document/listed'
	vNote = require 'views/object/content/note/listed'
	vFormat = require 'views/object/content/format/listed'

	# GROUPS
	vDepartement = require 'views/object/group/departement/listed'
	vOrganisation = require 'views/object/group/organisation/listed'
	vProject = require 'views/object/group/project/listed'

	'user': vUser

	'content/event': vEvent
	'content/link': vLink
	'content/video': vVideo
	'content/document': vDocument
	'content/note': vNote
	'content/format': vFormat

	'group/departement': vDepartement
	'group/organisation': vOrganisation
	'group/project': vProject
