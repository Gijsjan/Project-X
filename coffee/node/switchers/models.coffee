_ = require 'lodash'

class Models

	@models:
		'content': '../models/content'
		'note': '../models/content/note'
		'carpool': '../models/content/carpool'
		'carpool_trip': '../models/content/carpool_trip'
		'group': '../models/group'
		'person': '../models/person'

	@get: (type, id) ->
		model = require @models[type]
		model = if _.isObject id then new model id else new model 'id': id

module.exports = Models

# Content = require '../models/content'
# Group = require '../models/group'
# Person = require '../models/person'

# Note = require '../models/content/note'

# Department = require '../models/groups/department'
# Organisation = require '../models/groups/organisation'
# Project = require '../models/groups/project'

# Owner = require '../models/people/owner'
# Editor = require '../models/people/editor'
# Reader = require '../models/people/reader'
# Member = require '../models/people/member'

# Comment = require '../models/annotations/comment'

# ModelSwitcher =
# 	'content': Content
# 	'group': Group
# 	'person': Person

# 	'note': Note
	
# 	'departments': Department
# 	'organisations': Organisation
# 	'projects': Project

# 	'owners': Owner
# 	'editors': Editor
# 	'readers': Reader
# 	'members': Member
	
# 	'comments': Comment

# module.exports = ModelSwitcher