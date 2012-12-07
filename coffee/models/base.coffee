define (require) ->
	# _ = require 'underscore'
	# brrr = require 'underscore'
	Backbone = require 'backbone'
	collectionManager = require 'CollectionManager'
	modelManager = require 'ModelManager'
	ajax = require 'AjaxManager'
	# cInputTableRow = require 'collections/input/tablerow'
	hlpr = require 'helper'

	class BaseModel extends Backbone.Model

		'relations': {}

		initialize: ->
			@on 'change', (model, options) =>
				for own attribute, value of options.changes
					if @relations.hasOwnProperty(attribute)
						tmpValue = _.filter @get(attribute), (data) -> not data.false? and not data.true? # BUG??? ADDS FALSE AND TRUE ATTRIBUTES
						@relations[attribute] = tmpValue
						@unset attribute, 'silent': true

		parse: (response) ->
			# server returns @relations as attribute of model, so value has to be moved from attribute to class variable
			if response.relations
				@relations = response.relations
				delete response.relations

			super

		# sync: (method, model, options) ->
		# 	# console.log 'BaseModel.sync()'

		# 	storedModel = modelManager.models[@id]

		# 	# If a model is updated, the modelManager is updated on @parse(), but the collectionManager doesn't
		# 	# adjust automagically. When a model is updated, remove collections having given model.
		# 	# If the model is not present in the modelManager, it won't be present in the collectionManager
		# 	collectionManager.removeCollections(@id) if method is 'create'
		# 	collectionManager.removeChangedCollections(@id) if method is 'update' and storedModel?
		# 	collectionManager.removeChangedCollections(@id) if method is 'delete' and storedModel?

		# 	if method is 'read' and storedModel?
		# 		options.success(storedModel)
		# 	else
		# 		# the model does not exist yet but is loaded automagically due to reference
		# 		# a collection is not registered in sync() but in parse(), but if the model does the same
		# 		# all models in a collection are stored in the modelmanager and we only want to store
		# 		# the full model (not the ones in a collection with only id, title)
		# 		modelManager.register model if method isnt 'delete' # register on read, create and update
		# 		Backbone.sync(method, model, options)

		# override save to save the relations separately
		# save: (attributes, options) ->
		# 	@saveRelations() if not @isNew() and not _.isEmpty(@relations)

		# 	super

		# saveRelations: ->
		# 	ajax.put
		# 		'url': '/db/relations'
		# 		'data':
		# 			'modelData': @toJSON()
		# 			'relations': @relations
		# 		success: (data) ->
		# 			console.log data

		# getRelations: (args) ->
		# 	[success] = [args.success]

		# 	if @isNew() then success {} else
		# 		ajax.get
		# 			'url': '/db/'+@get('type')+'/'+@get('id')+'/relations'
		# 			'success': (relations) =>
		# 				@relations = relations
		# 				success()
