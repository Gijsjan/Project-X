define (require) ->
	# OBJECTS
	tplComment = require 'text!html/comment/edit.html'
	tplUser = require 'text!html/user/edit.html'

	# CONTENT
	tplEvent = require 'text!html/event/edit.html'
	tplLink = require 'text!html/link/edit.html'
	tplVideo = require 'text!html/video/edit.html'
	tplDocument = require 'text!html/document/edit.html'
	tplNote = require 'text!html/note/edit.html'
	tplFormat = require 'text!html/format/edit.html'

	# GROUPS
	tplDepartement = require 'text!html/departement/edit.html'
	tplOrganisation = require 'text!html/organisation/edit.html'
	tplProject = require 'text!html/project/edit.html'

	'object/comment': tplComment
	'object/user': tplUser
	
	'content/event': tplEvent
	'content/link': tplLink
	'content/video': tplVideo
	'content/document': tplDocument
	'content/note': tplNote
	'content/format': tplFormat

	'group/departement': tplDepartement
	'group/organisation': tplOrganisation
	'group/project': tplProject