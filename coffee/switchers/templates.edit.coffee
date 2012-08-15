define (require) ->
	# OBJECTS
	tplComment = require 'text!templates/comment/edit.html'
	tplUser = require 'text!templates/user/edit.html'

	# CONTENT
	tplEvent = require 'text!templates/event/edit.html'
	tplLink = require 'text!templates/link/edit.html'
	tplVideo = require 'text!templates/video/edit.html'
	tplDocument = require 'text!templates/document/edit.html'
	tplNote = require 'text!templates/note/edit.html'
	tplFormat = require 'text!templates/format/edit.html'

	# GROUPS
	tplDepartement = require 'text!templates/departement/edit.html'
	tplOrganisation = require 'text!templates/organisation/edit.html'
	tplProject = require 'text!templates/project/edit.html'

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