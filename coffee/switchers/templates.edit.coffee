define (require) ->
	# OBJECTS
	# tplComment = require 'text!html/comment/edit.html'
	tplPeople = require 'text!html/person/edit.html'

	# CONTENT
	tplNote = require 'text!html/content/note/edit.html'
	# tplEvent = require 'text!html/event/edit.html'
	# tplLink = require 'text!html/link/edit.html'
	# tplVideo = require 'text!html/video/edit.html'
	# tplDocument = require 'text!html/document/edit.html'
	# tplFormat = require 'text!html/format/edit.html'

	# GROUPS
	tplDepartment = require 'text!html/group/department/edit.html'
	tplOrganisation = require 'text!html/group/organisation/edit.html'
	tplProject = require 'text!html/group/project/edit.html'

	# 'object/comment': tplComment
	'people': tplPeople
	
	'notes': tplNote
	# 'content/event': tplEvent
	# 'content/link': tplLink
	# 'content/video': tplVideo
	# 'content/document': tplDocument
	# 'content/format': tplFormat

	'departments': tplDepartment
	'organisations': tplOrganisation
	'projects': tplProject