define (require) ->
	#OBJECTS
	# cTag = require 'collections/object/tag'
	# cComment = require 'collections/object/comment'
	# CONTENT
	# cEvent = require 'collections/object/content/event'
	# cLink = require 'collections/object/content/link'
	# cVideo = require 'collections/object/content/video'
	# cDocument = require 'collections/object/content/document'
	content = require 'config.form/content'
	note = require 'config.form/content/note'
	carpool = require 'config.form/content/carpool'
	
	person = require 'config.form/person'
	group = require 'config.form/group'
	# department = require 'config.form/group/department'
	# organisation = require 'config.form/group/organisation'
	# # cFormat = require 'config/object/content/format'
	# GROUPS
	# cProjects = require 'config/group/projects'
	# cOrganisations = require 'config/group/organisations'

	'content': content
	'note': note
	'carpool': carpool

	'person': person
	'group': group
	# 'departments': department
	# 'organisations': organisation
	# 'projects': cProjects
	# 'organisations': cOrganisations