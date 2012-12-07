define (require) ->
	#OBJECTS
	# cTag = require 'collections/object/tag'
	# cComment = require 'collections/object/comment'
	# CONTENT
	# cEvent = require 'collections/object/content/event'
	# cLink = require 'collections/object/content/link'
	# cVideo = require 'collections/object/content/video'
	# cDocument = require 'collections/object/content/document'
	person = require 'config.form/person'
	note = require 'config.form/content/note'
	department = require 'config.form/group/department'
	organisation = require 'config.form/group/organisation'
	# cFormat = require 'config/object/content/format'
	# GROUPS
	# cProjects = require 'config/group/projects'
	# cOrganisations = require 'config/group/organisations'

	'people': person
	'notes': note
	'departments': department
	'organisations': organisation
	# 'projects': cProjects
	# 'organisations': cOrganisations