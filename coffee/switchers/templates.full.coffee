define (require) ->
	tplUser = require 'text!templates/user/full.html'
	
	tplEvent = require 'text!templates/event/full.html'
	tplLink = require 'text!templates/link/full.html'
	tplVideo = require 'text!templates/video/full.html'
	tplDocument = require 'text!templates/document/full.html'
	tplNote = require 'text!templates/note/full.html'
	tplFormat = require 'text!templates/format/full.html'

	tplDepartement = require 'text!templates/departement/full.html'
	tplOrganisation = require 'text!templates/organisation/full.html'
	tplProject = require 'text!templates/project/full.html'

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