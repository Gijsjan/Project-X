define (require) ->
	tplUser = require 'text!html/user/full.html'
	
	tplEvent = require 'text!html/event/full.html'
	tplLink = require 'text!html/link/full.html'
	tplVideo = require 'text!html/video/full.html'
	tplDocument = require 'text!html/document/full.html'
	tplNote = require 'text!html/note/full.html'
	tplFormat = require 'text!html/format/full.html'

	tplDepartement = require 'text!html/departement/full.html'
	tplOrganisation = require 'text!html/organisation/full.html'
	tplProject = require 'text!html/project/full.html'

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