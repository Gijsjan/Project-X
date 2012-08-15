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

	'comment': mComment
	'user': mUser

	'event': mEvent
	'link': mLink
	'video': mVideo
	'document': mDocument
	'note': mNote
	'format': mFormat
	
	'departement': mDepartement
	'organisation': mOrganisation
	'project': mProject