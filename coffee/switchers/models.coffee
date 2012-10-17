define (require) ->
	# OBJECTS
	mUser = require 'models/object/user'
	mComment = require 'models/object/comment'

	# CONTENT
	mEvent = require 'models/object/content/event'
	mLink = require 'models/object/content/link'
	mVideo = require 'models/object/content/video'
	mDocument = require 'models/object/content/document'
	mNote = require 'models/object/content/note'
	mFormat = require 'models/object/content/format'
	
	# GROUPS
	mDepartement = require 'models/object/group/departement'
	mOrganisation = require 'models/object/group/organisation'
	mProject = require 'models/object/group/project'

	'object/comment': mComment
	'object/user': mUser

	'content/event': mEvent
	'content/link': mLink
	'content/video': mVideo
	'content/document': mDocument
	'content/note': mNote
	'content/format': mFormat
	
	'group/departement': mDepartement
	'group/organisation': mOrganisation
	'group/project': mProject