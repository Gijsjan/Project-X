define (require) ->
	tplUser = require 'text!html/user/listed.html'
	
	tplEvent = require 'text!html/event/listed.html'
	tplLink = require 'text!html/link/listed.html'
	tplVideo = require 'text!html/video/listed.html'
	tplDocument = require 'text!html/document/listed.html'
	tplNote = require 'text!html/note/listed.html'
	tplFormat = require 'text!html/format/listed.html'


	tplDepartement = require 'text!html/departement/listed.html'
	tplOrganisation = require 'text!html/organisation/listed.html'
	tplProject = require 'text!html/project/listed.html'

	'user': tplUser

	'content/event': tplEvent
	'content/link': tplLink
	'content/video': tplVideo
	'content/document': tplDocument
	'content/note': tplNote
	'content/format': tplFormat

	'group/departement': tplDepartement
	'group/organisation': tplOrganisation
	'group/project': tplProject