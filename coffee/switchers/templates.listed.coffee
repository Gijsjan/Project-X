define (require) ->
	tplUser = require 'text!templates/user/listed.html'
	
	tplEvent = require 'text!templates/event/listed.html'
	tplLink = require 'text!templates/link/listed.html'
	tplVideo = require 'text!templates/video/listed.html'
	tplDocument = require 'text!templates/document/listed.html'
	tplNote = require 'text!templates/note/listed.html'
	tplFormat = require 'text!templates/format/listed.html'


	tplDepartement = require 'text!templates/departement/listed.html'
	tplOrganisation = require 'text!templates/organisation/listed.html'
	tplProject = require 'text!templates/project/listed.html'

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