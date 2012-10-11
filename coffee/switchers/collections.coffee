define (require) ->
	#OBJECTS
	cTag = require 'collections/object/tag'
	cComment = require 'collections/object/comment'
	# CONTENT
	cEvent = require 'collections/object/content/event'
	cLink = require 'collections/object/content/link'
	cVideo = require 'collections/object/content/video'
	cDocument = require 'collections/object/content/document'
	cNote = require 'collections/object/content/note'
	cFormat = require 'collections/object/content/format'
	# GROUPS
	cProject = require 'collections/object/group/project'
	cDepartement = require 'collections/object/group/departement'
	cOrganisation = require 'collections/object/group/organisation'

	'tag': cTag
	'comment': cComment
	'content/event': cEvent
	'content/link': cLink
	'content/video': cVideo
	'content/document': cDocument
	'content/note': cNote
	'content/format': cFormat
	'project': cProject
	'departement': cDepartement
	'organisation': cOrganisation